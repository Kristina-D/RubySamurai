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
    # returns all created stations
    @@stations
  end

  def trains_block
    @station_trains.each { |train| yield(train) }
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

  attr_reader :station_name

  def train_list
    @station_trains
  end

  attr_reader :station_trains

  protected

  def validate!
    raise "Name can't be epmty" if @station_name.empty?
    true
  end
end
