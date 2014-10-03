require 'nokogiri'
require 'hashie'

module Redfinger
  class Link < Hashie::Mash
    def self.from_xml(xml_link)
      new_link = Link.new
      new_link[:rel]  = xml_link['rel']
      new_link[:href] = xml_link['href']
      new_link[:type] = xml_link['type']
      new_link
    end
    
    # Outputs the URL of the link, useful for using 
    # a Link directly in other libraries.
    def to_s
      self.href
    end
  end
end