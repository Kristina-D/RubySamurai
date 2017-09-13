class Train
  attr_reader :route, :number, :type, :speed
  attr_accessor :cars
  #so other class can read

  def initialize (number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
    @tooken_route = nil
  end

  def change_speed(delta)
    @speed = [[@speed + delta, 0].max, 350].min
  end

  def add_car(car)
    if car.type == @type
      @cars << car
    else
      puts "The car type doesn't correspond to the train type."
    end
  end

  def remove_car
    if @cars.length > 0
      @cars.delete_at(-1)
    end
  end

  def take_route(route)
    @current_index = 0
    @route = route
    @route.stations[@current_index].train_arrives(self)
    @tooken_route = route
  end

  def forward
    current_station.train_departs(self)
    @current_index += 1
    current_station.train_arrives(self)
  end

  def back
    current_station.train_departs(self)
    @current_index -= 1
    current_station.train_arrives(self)
  end

  def current_station
    @route.stations[@current_index]
  end

  def previous_station
    @route.stations[@current_index - 1]
  end

  def next_station
    @route.stations[@current_index + 1]
  end

  def cars_count
    @cars.length
  end

  def tooken_route 
    @tooken_route
  end

  def current_index
    @current_index
  end
end

def test
  moscow = Station.new("Moscow")
  piter = Station.new("Piter")
  tver = Station.new("Tver")
  balagoe = Station.new("Balagoe")

  route = Route.new(moscow, piter)
  
  route.insert_station(tver)
  route.insert_station(balagoe)
  #route.print
  
  t1 = Train.new(1, "cargo", 7)
  puts "now no trains in moscow #{moscow.trains}"
  puts "now no trains in tver #{tver.trains}"
  t1.take_route(route)
  puts "in Moscow 1 train appears #{moscow.trains}"
  t1.next_station
  t1.current_station
  p t1.current_station.name
  p t1.next_station.name
  t1.forward
  puts "now no trains in moscow #{moscow.trains}"
  puts "now 1 train in tver #{tver.trains}"
  t1.back
  puts "Train goes back"
  puts "now 1 train in moscow #{moscow.trains}"
  puts "now no trains in tver #{tver.trains}"
  t1.current_station
  puts "now no train in balagoe #{balagoe.trains}"
  p t1.previous_station
  puts "in 1 train in moscow #{moscow.trains}"
end

def test2
  t1 = Train.new(1, "cargo", 1)
  t1.remove_car
  p t1

  t1.remove_car
  p t1

  t1.change_speed(-10)
  t1.change_speed(400)
  t1.change_speed(30)
  p t1
  t1.add_car
  p t1
  t1.change_speed(-30)
  t1.change_speed(-350)
  p t1

  t1.add_car
  p t1

  t1.change_speed(30)
  t1.remove_car
  p t1

  t1.change_speed(-30)
  t1.remove_car
  p t1
end

