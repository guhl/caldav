require File.dirname(__FILE__) + '/../test_helper.rb'

class CalendarQueryTest < Test::Unit::TestCase 
  
  def test_event_without_param
    event = CalDAV::CalendarQuery.new.event
    assert_kind_of CalDAV::Filter::Component, event
    assert_equal 'VEVENT', event.name
  end
  
  def test_event_with_range
    timerange_query = CalDAV::CalendarQuery.new.event(1..2)
    assert_kind_of CalDAV::Filter::TimeRange, timerange_query
    assert_kind_of CalDAV::Filter::Component, timerange_query.parent
    assert_nil timerange_query.child
    
    assert_equal 1..2, timerange_query.range
  end
  
  def test_build_xml_with_event
    query = CalDAV::CalendarQuery.new.event()
    xml = Nokogiri::XML.parse(query.to_xml)
    assert_kind_of Nokogiri::XML::Element, xml.search("./cal:calendar-query/dav:prop/dav:getetag", xml.root.namespaces).first
    assert_kind_of Nokogiri::XML::Element, xml.search("./cal:calendar-query/dav:prop/cal:calendar-data", xml.root.namespaces).first    
    assert !xml.search("/cal:calendar-query/cal:filter", xml.root.namespaces).empty?
  end
  
end