require_relative 'instance_counter'
require_relative 'instance_validation'

class Station
  attr_reader :name, :stations

  include InstanceCounter
  include Validation

  @@stations = []

  def initialize(name)
    @station_name = name
    validate!
    @station_trains = []
    @@stations << self
    register_instance
  end

  def self.all
    #возвращает все станции (объекты), созданные на данный момент    
    @@stations
  end

  def trains_block(block)
    @station_trains.each { |train| block.call(train) }
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

  protected
  def validate!
    raise "Name can't be epmty" if @station_name.empty?
    true
  end
end