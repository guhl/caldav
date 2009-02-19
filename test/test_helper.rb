$:.unshift(File.dirname(__FILE__) + '/../lib')
$:.unshift(File.dirname(__FILE__) + '/mocks')

require 'rubygems'
require 'test/unit'
require 'breakpoint'
require 'caldav'
require 'mocha'
require 'webrat'

class Test::Unit::TestCase
  
private
  
  def prepare_response(test_name, response_name)
    Net::HTTP.responses << File.read(File.join(File.dirname(__FILE__), 'responses', test_name, "#{response_name}.txt"))
  end
  
  def assert_request(test_name, request_name)
    assert !Net::HTTP.requests.empty?, "No requests were made"
    expected = File.read(File.join(File.dirname(__FILE__), 'requests', test_name, "#{request_name}.txt")).split("\n")
    actual = Net::HTTP.requests.shift.split("\n")
    assert_match Regexp.new(expected.first.chomp), actual.first.chomp
    1.upto(expected.size) do |i|
      expected_value = expected[i] ? expected[i].chomp : nil
      actual_value = actual[i] ? actual[i].chomp : nil
      assert_equal expected_value, actual_value
    end
  end
  
  def assert_request_body(path, request)
    file = File.read(File.join(File.dirname(__FILE__), 'requests', *path ))
    assert_not_nil request
    assert_equal Nokogiri::XML(file).to_xml.strip!, Nokogiri::XML(request).to_xml.strip!
  end
  
  def assert_accessor(object, *methods)
    methods = methods.first if methods.first.is_a? Hash
    methods.each do |method, value|
      assert_respond_to object, method
      original_value = object.send(method)
      object.send("#{method}=", value || 'test') 
      assert_equal(value || 'test', object.send(method))
      assert_not_equal original_value, object.send(method)
    end 
  end
  
end

# Reference: http://www.vitarara.org/cms/hpricot_to_nokogiri_day_1
class String
  def strip
    self.gsub(/^[\302\240|\s]*|[\302\240|\s]*$/, '')
  end
  
  def strip!
    before = self.reverse.reverse
    self.gsub!(/^[\302\240|\s]*|[\302\240|\s]*$/, '')
    before == self ? nil : self
  end
end