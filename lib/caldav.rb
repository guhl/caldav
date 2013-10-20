require 'rubygems'
require 'builder'
require 'active_support'
require 'icalendar'
require 'tzinfo'
require 'net/http'
require 'net/https'
require 'extensions/net/http'
require 'extensions/icalendar/event'
require 'nokogiri'

Dir[File.join(File.dirname(__FILE__), 'caldav/**/*.rb')].sort.each { |lib| require lib }

module CalDAV
  NAMESPACES = { "xmlns:dav" => 'DAV:', "xmlns:cal" => "urn:ietf:params:xml:ns:caldav" }
  
  class Error < StandardError
    attr_reader :response
    
    def initialize(message, response)
      super(message)
      @response = response
    end
  end
end
