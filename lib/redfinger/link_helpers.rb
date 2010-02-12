require 'nokogiri'

module Redfinger
  module LinkHelpers
    def hcard
      relmap('http://microformats.org/profile/hcard')
    end
    
    def open_id
      relmap('http://specs.openid.net/auth/', true)
    end
    
    def profile_page
      relmap('http://webfinger.net/rel/profile-page')
    end
    
    def xfn
      relmap('http://gmpg.org/xfn/', true)
    end
    
    protected
    
    def relmap(uri, substring=false)
      @doc.css("Link[rel#{'^' if substring}=\"#{uri}\"]").map{|e| e['href']}
    end
  end
end
