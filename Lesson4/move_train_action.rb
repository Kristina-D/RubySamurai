require_relative 'store'

class MoveTrainStation
  def call(selected_train)
    puts "1. Move selected train forward."
    puts "2. Move selected train back."
    puts "Select the number of your action: "
    action_number = gets.chomp
      
    if "1" == action_number

        if selected_train.current_index < selected_train.tooken_route.stations.length - 1
            puts "lets move train"
            selected_train.forward
            puts "Train's current station is #{selected_train.current_station.station_name}."
        else
          puts "Train is on the last station"
        end

    elsif "2" == action_number

      if selected_train.current_index > 0
        puts "lets move train"
        selected_train.back
        puts "Train's current station is #{selected_train.current_station.station_name}."       
      else
        puts "Train is on its first station"
      end

    end
  end
end

