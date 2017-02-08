require 'csv'
require 'bunny'
require 'pry'

class Parser
  attr_reader :all_rows_array
  
  def read_csv(path_to_csv)
    @all_rows_array = []
    CSV.foreach(path_to_csv) do |row|
      student_hash = {}
      student_hash[:first_name] = row[2]
      student_hash[:last_name] = row[3]
      student_hash[:street] = row[6]
      student_hash[:city] = row[7]
      student_hash[:state] = row[8]
      student_hash[:zipcode] = row[9]
      @all_rows_array << student_hash
    end
    @all_rows_array.shift
    @all_rows_array
  end
end