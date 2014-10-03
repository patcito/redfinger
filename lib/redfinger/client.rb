require 'restclient'
require 'nokogiri'
require 'uri'

module Redfinger
  class Client
    attr_accessor :account, :domain, :uri_template, :xrd_timeout, :xrd_open_timeout

    def initialize(email, uri_template = nil)
      self.account = normalize(email)
      self.domain = account.split('@').last

      self.xrd_timeout = 10
      self.xrd_open_timeout = 5
    end

    def finger
      self.uri_template ||= retrieve_template_from_xrd
      begin
        return Finger.new self.account, RestClient.get(swizzle).body
      rescue RestClient::ResourceNotFound
        return Finger.new self.account, RestClient.get(swizzle(account_with_scheme)).body
      end
    end

    def xrd_url(ssl = true)
      "http#{'s' if ssl}://#{domain}/.well-known/host-meta"
    end

    private

    def swizzle(account = nil)
      account ||= self.account
      uri_template.gsub '{uri}', URI.escape(self.account)
    end

    def retrieve_template_from_xrd(ssl = true)
      xrd_client =  RestClient::Resource.new(xrd_url(ssl),
                      :timeout => self.xrd_timeout,
                      :open_timeout => self.xrd_open_timeout
                    )

      doc = Nokogiri::XML::Document.parse(xrd_client.get.body)
      if doc.namespaces["xmlns"] != "http://docs.oasis-open.org/ns/xri/xrd-1.0"
        # it's probably not finger, let's try without ssl
        # http://code.google.com/p/webfinger/wiki/WebFingerProtocol
        # says first ssl should be tried then without ssl, should fix issue #2
        doc = Nokogiri::XML::Document.parse(RestClient.get(xrd_url(false)).body)
      end

      doc.at('Link[rel=lrdd]').attribute('template').value
    rescue  Errno::ECONNREFUSED, Errno::ETIMEDOUT,
            RestClient::RequestTimeout, RestClient::ResourceNotFound, RestClient::Forbidden
      if ssl
        retrieve_template_from_xrd(false)
      else
        raise Redfinger::ResourceNotFound, "Unable to find the host XRD file."
      end
    end

    def normalize(email)
      email.sub! /^acct:/, ''
      email.downcase
    end

    def account_with_scheme
      "acct:" + account
    end
  end
end
