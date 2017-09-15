class MoveTrainStation
  def call(selected_train)
    puts "1. Move selected train forward."
    puts "2. Move selected train back."
    puts "Select the number of your action: "
    action_number = gets.chomp
      
    if action_number == "1"
      if selected_train.forward
        puts "Train's current station is #{selected_train.current_station.station_name}." 
      else
        puts "Train is on the last station"
      end
      
    elsif action_number == "2"
      if selected_train.back
        puts "Train's current station is #{selected_train.current_station.station_name}."       
      else
        puts "Train is on its first station"
      end

    end
  end
end

