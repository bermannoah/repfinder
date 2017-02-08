require 'congress'
require 'csv'
require 'pry'

class Parser
  attr_reader :all_rows_array
  
  def read_csv(path_to_csv)
    @all_rows_array = []
    CSV.foreach(path_to_csv) do |row|
      @all_rows_array.push(row)
    end
    @all_rows_array
  end
end