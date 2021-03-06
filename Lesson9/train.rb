require_relative 'manufacturer'
require_relative 'instance_counter'
require_relative 'instance_validation'
require_relative 'interface'
require_relative 'validation'
require_relative 'accessors'

class Train
  attr_reader :route, :type, :speed, :current_index, :tooken_route
  attr_accessor :cars, :number

  NUMBER_FORMAT = /^\w{3}(-)?[a-z0-9]{2}$/i

  include Manufacturer
  include InstanceCounter
  include Validation
  extend Acessors

  @@trains_by_number = {}

  validate :number, :presence
  validate :type, :presence
  validate :number, :format, NUMBER_FORMAT
  #validate :type, :kinds, :cargo, :passenger

  def initialize(number, type)
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

  def self.find(number)
    # returns train number
    @@trains_by_number[number]
  end

  def each_train
    @cars.each_with_index { |car, index| yield(car, index) }
  end

  def change_speed(delta)
    @speed = [[@speed + delta, 0].max, 350].min
  end

  def add_car(car)
    @cars << car if car.type.to_s == @type
  end

  def remove_car
    @cars.pop unless @cars.empty?
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
end
