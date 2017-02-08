require 'minitest/autorun'
require 'minitest/pride'
require 'pry'
require './parser'

class TestParser < Minitest::Test 
  def setup
    @parser = Parser.new
  end
  
  def test_it_reads_the_csv
    result = @parser.read_csv("./event_attendees.csv")
    assert_equal Array, result.class
  end

  def test_it_reads_the_csv_and_has_the_right_data
    result = @parser.read_csv("./event_attendees.csv")
    assert_equal "Allison", result[1][2]
  end
  
  
end
