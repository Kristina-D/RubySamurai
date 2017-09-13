class Station
  attr_reader :name, :trains, :train_list_print

  def initialize(name)
    @station_name = name
    @station_trains = []
  end

  def train_arrives(train)
    @station_trains << train
  end

  def train_departs(train)
    @station_trains.delete(train)
  end

  def trains_by_type(type)
      @station_trains.select { |train| train.type == type }
  end

  def station_name
    @station_name
  end

  def train_list_print
    if @station_trains.empty?
      puts "There are no trains on this station"
    else
      puts "The train list of this station: "
      @station_trains.each {|train| puts "Train - #{train.number} - #{train.type}"}
    end
  end

  def station_trains
    @station_trains
  end

end