require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'instance_validation'
require_relative 'interface'

class Train
  attr_reader :route, :type, :speed, :current_index, :tooken_route 
  attr_accessor :cars, :number

  NUMBER_FORMAT = /^\w{3}(-)?[a-z0-9]{2}$/i

  include Manufacturer
  include InstanceCounter
  include Validation

  @@trains_by_number = {}

  def initialize (number, type)
    @number = number
    @type = type
    validate!
    @speed = 0
    @cars = []
    @tooken_route
    @@trains_by_number[number] = self
    register_instance
  end

  def self.all
    @@trains_by_number.values
  end

  def self.find (number)
    #который принимает номер поезда (указанный при его создании)
    @@trains_by_number[number]
  end

  def trains_block(block)
    @station_trains.each { |train| block.call(train) }
  end
  
  def change_speed(delta)
    @speed = [[@speed + delta, 0].max, 350].min
  end

  def add_car(car)
    if car.type.to_s == @type
      @cars << car
    end
  end

  def remove_car
    if @cars.length > 0
      @cars.pop
    end
  end

  def take_route(route)
    @current_index = 0
    @tooken_route = route
    @tooken_route.stations[@current_index].train_arrives(self)
  end

  def forward
    move = false
    if @current_index < @tooken_route.stations.length - 1
      current_station.train_departs(self)
      @current_index += 1
      current_station.train_arrives(self)
      move = true
    else
      move = false
    end
    move
  end

  def back
    move = false
    if current_index > 0
      current_station.train_departs(self)
      @current_index -= 1
      current_station.train_arrives(self)
      move = true
    else
      move = false
    end
    move
  end

  def current_station
    @tooken_route.stations[@current_index]
  end

  def previous_station
    @tooken_route.stations[@current_index - 1]
  end

  def next_station
    @tooken_route.stations[@current_index + 1]
  end

  def cars_count
    @cars.length
  end

  protected
  def validate!
    raise RuntimeError, "Number can't be empty. Please try again." if number.empty?
    raise RuntimeError,"Type can't be empty. Please try again." if type.empty?
    raise RuntimeError,"Train type must be 'cargo' or 'passenger'. Please try again." if type != "passenger" && @type != "cargo"
    raise RuntimeError, "Train number has invalid format" if number !~ NUMBER_FORMAT
    true
  end
end