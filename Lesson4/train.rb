class Train
  attr_reader :route, :number, :type, :speed, :current_index, :tooken_route 
  attr_accessor :cars

  def initialize (number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
    @tooken_route
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
end