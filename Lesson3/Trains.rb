class Station
  attr_reader :name

  def initialize(name)
    @name = name
    @trains = []
    @train_list = []
    #@index = 0
    #@name = 
    #@stations << Station.new
  end

  #@trains = [Train.new, Train.new, Train.new]
  #@stations = {"Madrid" => 1, "Milan" => 2, "Rome" => 3, "Saragosa" => 4, "Neapol" => 5}

  # def st
  #   puts @stations
  # end
  def trains_list
    if @trains.empty?
      puts "There are no trains on the station"
    elsif
      @train_list.each do |i|
        print "#{i[0]} - #{i[1]} - #{i[2]}\n"
      end
        #i.each do |n, t, car_number|
        #print "#{n} - #{t} - #{car_number}"
        #print "\n"
      
    
      #list@trains.number + @trains.type + @trains.number.car_number
    end
  end

  def train_arrives(train)
    @trains << train
    @train = train
    @train_list << [@train.number.to_i, @train.type.to_s, @train.car_number.to_i]
  end

  def train_departs(train)
    @trains.delete(@train)
    puts @trains

    @train_list.each do |i|
      if i[0] == @train.number.to_i
        @train_list.delete(i)
      end
    end
  end

  def trains_count
    count_passenger = 0
    count_cargo = 0
    
    @trains.each do |train|
      puts train.type.to_s.downcase 

      if train.type.to_s.downcase == "passenger"
        #should take all the elements from trains array by type passenger
        count_passenger += 1
        #puts "passenger train"
      elsif 
        #should take all the elements from trains array by type cargo
        count_cargo += 1
        #puts "cargo train"
      end
    end

    puts "There are #{count_passenger} passenger trains and #{count_cargo} cargo trains on the station"
  end

  # def stations
  #   @stations = {"Madrid" => 1, "Milan" => 2, "Rome" => 3, "Saragosa" => 4, "Neapol" => 5}
  # end

  # def st(object)
  #   object == self
  # end

  # def self.method
  #   puts "Station name: "
  #   #S.method
  # end
end

class Train
  attr_reader :number
  attr_reader :type
  attr_reader :car_number
  #so other clas can read

  def initialize (number, type, car_number)
    @train_numbers = []

    if (type.downcase != "passenger")&&( type.downcase != "cargo")
      raise("Error")
    elsif 
      #if defined? @number == '123' then puts 
      #if @number.exists?#@train_numbers.include?(number)
      #  print "This train number already exists"
      # elsif 
      #   @train_numbers<<number
      #   @number = number
      #end
      @number = number
      @type = type
      @car_number = car_number
      @speed = 0
    end
  end

  def speed_up(upper)
    @upper = upper
    if @speed < 350
      @speed += upper
    end
  end

  def current_speed
    puts @speed
  end

  def speed_down(down)
    @down = down
    if @speed < down
      puts "Error: the entered number should be lesser then the current speed. Current speed: #{@speed}."
    elsif 
      @speed -= down
    end
  end

  def number_of_cars
    puts @car_number
  end

  def add_car
    if @speed == 0
      @car_number += 1
    elsif 
      puts "Speed is not zero. Please stop the train in order to add the car."
    end  
  end

  def remove_car
    if @speed == 0
      @car_number -= 1
    elsif 
      puts "Speed is not zero. Please stop the train in order to remove the car."
    end
  end

  def takes_route(route)
    @i = 0
    @route = route
    #puts @route
    puts @start_point
    @train_position = route.start_point
    @i = 0
    puts @train_position
    print "Train is on the station #{@train_position}"
  end

  def forward
    @i += 1
    @train_position = @route.route_stations_only[@i]
    puts @route.route_stations_only[@i]
  end

  def back
    @i -= 1
    @train_position = @route.route_stations_only[@i]
    puts @route.route_stations_only[@i]
  end

  def location_data
    if @i > 0
      puts "Previous station is #{@route.route_stations_only[@i-1]}"
    end

    puts "Current station is #{@route.route_stations_only[@i]}"

    if @i+1 < @route.route_stations_only.length
      puts "Next station is #{@route.route_stations_only[@i+1]}"
    end
  end

end

class Route
  #attr_writer :stations
  attr_reader :start_point
  attr_reader :route_stations_only
  #attr_reader :route

  def initialize(start_point, destination)
    #@route = []
    #@route_startions_only = []
    @start_point = start_point
    @destination = destination
    #@route_stations_only << start_point
    #@route_stations_only << destination
    #@route.merge!({0 => start_point})
    #@route.merge!({1 => destination})
    @route_stations_only = [start_point, destination]

    @stations = ["Madrid", "Milan", "Rome", "Barselona", "Saragosa"]
  end

  def route
    puts @route_stations_only 
    #puts @route
    #puts @stations
  end

  def insert_s(station, index)
    #@stations.each do |s|
     # if @stations.include?(s)
    @route_stations_only.insert(index, station)
      #end
    #end
  end

  def delete_s(index)
    @route_stations_only.delete_at(index)
  end

     #@route.merge!({index => station})
  #puts stations.key(1)
end
