class Store
  attr_accessor :stations

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def self
    puts self
  end

  def add_station(station)
    if station.nil?
      puts "Station name must be entered. Please try again."
    else
      puts "New station #{station.station_name} is created"
      @stations << station
      print_stations_list
    end
  end

  def add_train(train)
    if train.nil?
      puts "Train type must be 'cargo' or 'passenger'. Please try again."
    else
      puts "New #{train.type} train is created"
      @trains << train
      print_trains_list
    end
  end

  def add_route
    if @stations.empty?
      puts "---NO EXISTING STATIONS----"
    elsif @stations.length > 1
      print_stations_list
      station_names = CreateRouteAction.new.call
      
      if station_existance(station_names[0]).nil? && station_existance(station_names[1]).nil?
        puts "First and last stations don't exist"
      elsif station_existance(station_names[0]).nil?
        puts "First station doesn't exist"
      elsif station_existance(station_names[1]).nil?
        puts "Last station doesn't exist"
      else
        first_station = station_existance(station_names[0])
        last_station = station_existance(station_names[1])
        @routes << Route.new(first_station, last_station)
        puts "New route is created:"
        puts "Route: #{station_names[0]} - #{station_names[1]}"
      end

    else
      puts "Create at least 2 stations in order to be able to create the route. "
    end
  end

  def modify_route
    if @routes.empty?
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
          selected_route.delete_station(station_to_remove)
        end
      end
    end
  end

  def put_train_on_route
    if @trains.empty?
      puts "---NO EXISTING TRAINS----"
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = train_existatnce(train_number)

      if selected_train.nil?
        puts "Train is not found"
      else
        puts "Train is found"

        if @routes.empty?
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
    if @trains.empty?
      puts "---NO EXISTING TRAINS----"
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = train_existatnce(train_number)

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
    if @trains.empty?
      puts "---NO EXISTING TRAINS----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    elsif @stations.empty?
      puts "---NO EXISTING STATIONS----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    elsif @routes.empty?
      puts "---NO EXISTING ROUTES----"
      puts "In order to proceed to this action make sure that: 1.train exists, 2.route exists 3.train is on the route."
    else
      print_trains_list
      puts "Please select a train by its number:"
      train_number = gets.chomp
      selected_train = train_existatnce(train_number)

      if selected_train.nil?
        puts "Train is not found"
      else
        puts "Train is found"

        if selected_train.tooken_route.nil?
          puts "Train is not on a station. Make sure that selected train is on the route."
        else
          MoveTrainStation.new.call(selected_train)
        end
      end
    end
  end

  def check_out_stations_list_with_trains
    if stations.empty?
      puts "---NO EXISTING STATIONS----"
    elsif stations.length > 0
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

    @stations.each do |station|
      if station.station_name == search_station_name
        exist = true
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

  def train_existatnce(train_number)
    selected_train = nil

    @trains.each do |train|
      if train.number == train_number
        selected_train = train
      end
    end
    selected_train
  end

  def print_trains_list
    puts "List of trains:"
    puts "Train - Number - Type"
    @trains.each {|train| puts "Train - #{train.number} - #{train.type}"}
  end

  def print_stations_list
    puts "List of stations:"
    @stations.each {|station| puts "#{station.station_name}"}
  end

  def routes_list
    @hash_routes = {}

    @routes.each_with_index do |route, index|
      @route = route
      @hash_routes.merge!({"#{index+1}" => route})
      puts "Route Number #{index+1}: "
      route.stations.each {|station| puts station.station_name}
    end
  end
end