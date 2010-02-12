require 'nokogiri'
require 'hashie'

module Redfinger
  class Link < Hashie::Mash
    def initialize(xml_link)
      self[:rel] = xml_link['rel']
      self[:href] = xml_link['href']
      self[:type] = xml_link['type']
    end
    
    def to_s
      self.href
    end
  end
end