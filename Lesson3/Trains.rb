class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def train_arrives(train)
    @trains << train
  end

  def train_departs(train)
    @trains.delete(train)
  end

  def trains_by_type(type)
      @trains.select { |train| train.type == type }
  end
end

class Train
  attr_reader :route, :number, :type, :car_count, :car_count, :speed
  #so other class can read

  def initialize (number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
  end

  def change_speed(delta)
    @speed = [[@speed + delta, 0].max, 350].min
  end

  def add_car
    @car_count += 1 if @speed == 0
  end

  def remove_car
    @car_count -= 1 if (@speed == 0) && (@car_count > 0)
  end

  def take_route(route)
    @i = 0
    @route = route
    route.stations[0].train_arrives(self)
  end

  def forward
    current_station.train_departs(self)
    @i += 1
    current_station.train_arrives(self)
  end

  def back
    current_station.train_departs(self)
    @i -= 1
    current_station.train_arrives(self)
  end

  def current_station
    @route.stations[@i]
  end

  def previous_station
    @route.stations[@i - 1]
  end

  def next_station
    @route.stations[@i + 1]
  end
end

class Route
  def initialize(start_point, destination)
    @stations = [start_point, destination]
  end

  def stations
    @stations.dup
  end

  def insert_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if (@stations.index(station) == 0) || (@stations.index(station) + 1 == @stations.length)
    
    @stations.delete(station)
  end

  def next_station(index_of_current_station)
      @stations[index_of_current_station + 1]
  end

  def previous_station(index_of_current_station)
    if index_of_current_station > 0
      @stations[index_of_current_station - 1]
    end
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
  route.print
  
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

