class Station
  attr_reader :name
  attr_reader :trains

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

  def trains_count(type)
    if trains = @trains.select { |type| type == type }.empty?
      return
    else
      @trains.select { |train| train.type.to_s == type }
    end
  end

  def trains_count_print(type)
    if trains_count(type).nil?
      puts "Thereare no #{type} trains at the station #{self.name}."
    else
      p trains_count(type)
    end
  end

  def print
    puts self.name
  end
end

class Train
  attr_reader :route
  attr_reader :number
  attr_reader :type
  attr_reader :car_count
  attr_reader :speed
  #so other class can read

  def initialize (number, type, car_count)
    @number = number
    @type = type
    @car_count = car_count
    @speed = 0
  end

  def change_speed(i)
    if ((i > 0) && (@speed + i < 350)) || ((i < 0) && (@speed + i >= 0))
      @speed += i
    else
      puts "Speed should be between 0 and 350. Current speed: #{@speed}."
    end
  end

  def add_car
    if @speed == 0
      @car_count += 1
    else
      return
    end
  end

  def remove_car
    if (@speed == 0) && (@car_count > 0)
      @car_count -= 1
    else
      return
    end
  end

  def takes_route(route)
    @route = route
    route.stations[0].train_arrives(self)
  end

  def forward
    return if next_station.nil?

    station = next_station
    current_station.train_departs(self)
    station.train_arrives(self)
  end

  def back
    return if previous_station.nil?

    station = previous_station
    current_station.train_departs(self)
    station.train_arrives(self) 
  end

  def current_station
    @route.stations.select { |station| station.trains.include?(self) }.first
  end

  def current_station_print
    puts "Current station is #{self.current_station.name}"
  end

  def previous_station
    @route.previous_station(self.current_station)
  end

  def next_station
    @route.next_station(self.current_station)
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
    @stations.delete(station)
  end

  def print
    puts @stations.map(&:name).join(", ")
  end

  def next_station(station)
    if (index_of_station = stations.index(station)) == stations.length
      nil
    else
      @stations[index_of_station + 1]
    end
  end

  def previous_station(station)
    if (index_of_station = stations.index(station)) == 0
      nil
    else
      @stations[index_of_station - 1]
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
  #moscow.train_arrives(t1)
  t1.takes_route(route)
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

def test3
  moscow = Station.new("Moscow")
  piter = Station.new("Piter")
  tver = Station.new("Tver")
  balagoe = Station.new("Balagoe")

  t2 = Train.new(2, "cargo", 8)
  t3 = Train.new(3, "passenger", 8)
  route = Route.new(moscow, piter)
  route.insert_station(tver)
  route.insert_station(balagoe)
  route.print
  route.delete_station(tver)
  route.print
  moscow.print
  tver.train_arrives(t2)
  tver.trains_count("cargo")
  tver.trains_count_print("cargo")
  tver.train_arrives(t3)
  tver.trains_count_print("passenger")
  tver.train_departs(t2)
  tver.train_departs(t3)
  tver.trains_count_print("cargo")
  tver.trains_count_print("passenger")
end
