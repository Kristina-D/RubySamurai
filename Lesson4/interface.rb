require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'passenger_car'
require_relative 'station'
require_relative 'route'
require_relative 'train_action'
require_relative 'store'
require_relative 'station_action'
require_relative 'route_action'
require_relative 'move_train_action'

class Interface
  attr_accessor :store

  def initialize
    @store = Store.new
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
      case gets.chomp
      when "9" then return
      when "1" then add_station
      when "2" then add_route
      when "3" then modify_route
      when "4" then add_train
      when "5" then put_train_on_route
      when "6" then modify_train_cars
      when "7" then move_train
      when "8" then check_out_stations_list_with_trains
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
