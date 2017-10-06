require_relative 'instance_counter'
require_relative 'instance_validation'
require_relative 'validation'
require_relative 'accessors'

class Station
  attr_reader :name, :stations, :station, :station_name, :station_trains

  include InstanceCounter
  include Validation
  extend Acessors

  @@stations = []

  validate :station_name, :presence
  validate :station, :type, Station

  def initialize(name)
    @station_name = name
    validate!
    @station_trains = []
    @station = self
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

  def train_list
    @station_trains
  end
end
