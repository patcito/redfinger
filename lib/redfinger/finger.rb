require 'nokogiri'

module Redfinger
  class Finger
    def initialize(xml)
      @doc = Nokogiri::XML::Document.parse(xml)
      @subject = @doc.at_css('Subject').content
    end
    
    def links
      @links ||= @doc.css('Link').map{|l| Link.new(l)}
    end
    
    def inspect
      "<#Redfinger::Finger subject=\"#{@subject}\">"
    end
    
    include Redfinger::LinkHelpers
  end
end