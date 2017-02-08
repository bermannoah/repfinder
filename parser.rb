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
  
  def publish_data
    read_csv("./event_attendees.csv")
    connection = Bunny.new
    connection.start
    
    channel = connection.create_channel
    
    send_queue = channel.queue("send.hash_rows_1")
    response_queue = channel.queue("send.response_1")
    counter = 0 
    response_queue.subscribe do |delivery_info, metadata, payload|
      while counter <= 5174
        if JSON.parse(payload) == "Processed. Waiting..."
          puts "Success. Sending next row..."
          send_queue.publish(@all_rows_array[counter])
          counter += 1
        else
          puts "An error has occurred."
        end
      end
    end
  end
  
end

parser = Parser.new
parser.publish_data