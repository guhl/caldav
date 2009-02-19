module CalDAV
  module Request
    class Mkcalendar
      attr_accessor :displayname, :description
      
      def initialize(displayname = nil, description = nil)
        @displayname = displayname
        @description = description
      end

      def to_xml(xml = Builder::XmlMarkup.new(:indent => 2))
        xml.instruct!
        xml.cal :mkcalendar, CalDAV::NAMESPACES do
          xml.dav :set do
            xml.dav :prop do
              xml.dav :displayname, displayname unless displayname.blank?
              xml.tag! "cal:calendar-description", description, "xml:lang" => "en" unless description.blank?
            end
          end
        end
      end

    end    
  end
end