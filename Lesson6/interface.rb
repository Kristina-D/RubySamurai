require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'station'
require_relative 'route'

class Interface

  def menu
    loop do
      puts "List of possible actions:"
      puts "1. Create a station"
      puts "2. Create a route"
      puts "3. Modify route"
      puts "4. Create a train"
      puts "5. Put a train on the route"
      puts "6. Add and remove cars from the trains"
      puts "7. Move train"
      puts "8. Check-out the list of stations and trains on the stations"
      puts "9. Find train"
      puts "10. Exit"      
      puts "Select the number of your action: "
      case gets.chomp
      when "10" then return
      when "1" then add_station
      when "2" then add_route
      when "3" then modify_route
      when "4" then add_train
      when "5" then put_train_on_route
      when "6" then modify_train_cars
      when "7" then move_train
      when "8" then check_out_stations_list_with_trains
      when "9" then find_train
      end
    end
  end

  def add_station
    puts "Enter the name of the Station: "
    station_name = gets.chomp.downcase

    if station_name.empty?
      puts "Station name must be entered. Please try again."
    else
      station = Station.new(station_name)
      puts "New station #{station.station_name} is created"
      print_stations_list
    end

  end

  def add_train
  attempt = 0
  begin
    puts "Please enter the train number: "
    number = gets.chomp

    puts "Please enter the train type (enter cargo or passenger): "
    type = gets.chomp

    train = Train.new(number, type)
  rescue RuntimeError => e
    puts e.message
    attempt += 1
    retry if attempt < 3
  ensure
    puts "There were #{attempt} attempts"
  end
    
    if train
      puts "New #{train.type} train is created"
      print_trains_list
    end
  end

  def find_train
    puts "Enter the number of train you search for:"
    number  = gets.chomp

    if Train.find(number)
      puts "Train is found"
    else
      puts "Train is not found"
    end
  end

  def add_route
    if Station.all.empty?
      puts "---NO EXISTING STATIONS----"
    elsif Station.all.length > 1
      print_stations_list

      puts "Enter name of the 1st station: "
      first_station_name = gets.chomp.downcase

      puts "Enter name of the last station: "
      last_station_name = gets.chomp.downcase
      
      if station_existance(first_station_name).nil? && station_existance(last_station_name).nil?
        puts "First and last stations don't exist"
      elsif station_existance(first_station_name).nil?
        puts "First station doesn't exist"
      elsif station_existance(last_station_name).nil?
        puts "Last station doesn't exist"
      else
        first_station = station_existance(first_station_name)
        last_station = station_existance(last_station_name)
        route = Route.new(first_station, last_station)
        puts "New route is created:"
        puts "Route: #{first_station_name} - #{last_station_name}"
      end

    else
      puts "Create at least 2 stations in order to be able to create the route. "
    end
  end

  def modify_route
    if Route.all.empty?
      puts "---NO EXISTING ROUTES----"
    else
      routes_list
      puts "select the number of your route: "
      route_number = gets.chomp
      
      if route_existance(route_number).nil?
        puts "Route is not found"
      else
        selected_route = route_existance(route_number)

        puts "1. Add a station in the selected route."
        puts "2. Remove a station from the selected route."
        puts "Select the number of your action: "
        action_number = gets.chomp

        if action_number == "1" 
          print_stations_list

          puts "select the station you want to add to your route: "
          selected_station_name = gets.chomp

          if station_existance(selected_station_name).nil?
            puts "This station does not exist"
          else
            station = station_existance(selected_station_name)
            selected_route.insert_station(station)
            puts "Station #{station.station_name} is added"
          end
        elsif action_number == "2"
          puts "Enter name of the station you want to remove: "
          removing_station_name = gets.chomp.downcase

          station_to_remove = station_existance(removing_station_name)

          if selected_route.delete_station(station_to_remove)
            puts "Station #{station_to_remove.station_name} is deleted"
          else
            puts "First and last stations of the route can't be deleted"
          end
        end
      end
    end
  end

  def put_train_on_route
    if Train.all.empty?
      puts "---NO EXISTING TRAINS----"
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = Train.find (train_number)

      if selected_train.nil?
        puts "Train is not found"
      else
        puts "Train is found"

        if Route.all.empty?
          puts "---NO EXISTING ROUTES----"
          puts "Please create a route in order to put a train on it"
        else
          routes_list
          puts "select the number of your route: "
          route_number = gets.chomp

          if route_existance(route_number).nil?
            puts "Route is not found"
          else
            selected_route = route_existance(route_number)
            selected_train.take_route(selected_route)
            puts "Train is on the first station of your route."
            puts "Train's current station is #{selected_train.current_station.station_name}." 
          end
        end
      end
    end
  end


  def modify_train_cars
    if Train.all.empty?
      puts "---NO EXISTING TRAINS----"
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = Train.find (train_number)

      puts "1. Add a car to the selected train."
      puts "2. Remove a car from the selected train."
      puts "Select the number of your action: "
      action_number = gets.chomp
      
      if "1" == action_number
        if selected_train.type == "cargo"
          selected_train.add_car(CargoCar.new)
        elsif selected_train.type == "passenger"
          selected_train.add_car(PassengerCar.new)
        end
        
        puts "Car is added to the selected train"
        puts "Now selected train has #{selected_train.cars_count} cars."

      elsif "2" == action_number
        selected_train.remove_car
        puts "Now selected train has #{selected_train.cars_count} cars."
      end
    end
  end

  def move_train
    if Train.all.empty?
      puts "---NO EXISTING TRAINS----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    elsif Station.all.empty?
      puts "---NO EXISTING STATIONS----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    elsif Route.all.empty?
      puts "---NO EXISTING ROUTES----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = Train.find (train_number)

      if selected_train.nil?
        puts "Train is not found"
      else
        puts "Train is found"

        if selected_train.tooken_route.nil?
          puts "Train is not on a station. Make sure that selected train is on the route."
        else
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
    end
  end

  def check_out_stations_list_with_trains
    if Station.all.empty?
      puts "---NO EXISTING STATIONS----"
    else
      print_stations_list
      puts "Select the station name to display its trains list"
      selected_station_name = gets.chomp

      if station_existance(selected_station_name).nil?
        puts "This station does not exist"
      else
        selected_station = station_existance(selected_station_name)
        list =  selected_station.train_list

        if list.empty?
          puts "There are no trains on this station"
        else
          puts "The train list of this station: "
          list.each {|train| puts "Train - #{train.number} - #{train.type}"}
        end

      end
    end
  end
    
  def station_existance(search_station_name)
    new_station = nil

    Station.all.each do |station|
      if station.station_name == search_station_name
        new_station = station
      end
    end
    new_station
  end

  def route_existance(route_number)
    if @hash_routes.has_key?(route_number)
      @hash_routes[route_number]
    end
  end

  def print_trains_list
    puts "List of trains:"
    puts "Train - Number - Type"
    Train.all.each {|train| puts "Train - #{train.number} - #{train.type}"}
  end

  def print_stations_list
    puts "List of stations:"
    Station.all.each {|station| puts "#{station.station_name}"}
  end

  def routes_list
    @hash_routes = {}

    Route.all.each_with_index do |route, index|
      @route = route
      @hash_routes.merge!({"#{index+1}" => route})
      puts "Route Number #{index+1}: "
      route.stations.each {|station| puts station.station_name}
    end
  end
end