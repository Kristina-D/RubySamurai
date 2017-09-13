require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'station'
require_relative 'route'
require_relative 'null_action'
require_relative 'train_action'
require_relative 'store'
require_relative 'station_action'
require_relative 'route_action'
require_relative 'select_route'
require_relative 'move_train_action'

class Interface
attr_accessor :store

  def call
    @store = Store.new
    @store.call
    menu
  end

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
      puts "9. Exit"
      puts "Select the number of your action: "
      action_number = gets.chomp

    break if action_number == "9"
      if action_number == "1"
        add_station
      elsif action_number == "2"
        add_route
      elsif action_number == "3"
        modify_route
      elsif action_number == "4"
        add_train
      elsif action_number == "5"
        put_train_on_route
      elsif action_number == "6"
        modify_train_cars
      elsif action_number == "7"
        move_train
      elsif action_number == "8"
        check_out_stations_list_with_trains
      end
    end
  end

  def add_train
    @store.add_train(CreateTrainAction.new.call)
  end

  def add_station
    @store.add_station(CreateStationAction.new.call)
  end

  def add_route
    @store.add_route
  end
    
  def modify_route
    @store.modify_route
  end

  def check_out_stations_list_with_trains
    @store.check_out_stations_list_with_trains
  end

  def put_train_on_route
    @store.put_train_on_route
  end
    
  def modify_train_cars
    @store.modify_train_cars
  end

  def move_train
    @store.move_train
  end
end
