require 'nokogiri'

module Redfinger
  # The result of a Webfinger. For more information about
  # special helpers that are availale to pull specific types
  # of URLs, see Redfinger::LinkHelpers
  class Finger
    def initialize(subject, xml) # :nodoc:
      @doc = Nokogiri::XML::Document.parse(xml)
      @subject = subject
    end
    
    # All of the links provided by the Webfinger response.
    def links
      @links ||= @doc.css('Link').map{|l| Link.from_xml(l)}
    end
    
    def inspect # :nodoc:
      "<#Redfinger::Finger subject=\"#{@subject}\">"
    end
    
    include Redfinger::LinkHelpers
  end
end