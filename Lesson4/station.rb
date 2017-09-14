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

  def train_list
    @station_trains
  end

  def station_trains
    @station_trains
  end

end