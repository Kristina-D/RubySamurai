require_relative 'instance_counter'
require_relative 'instance_validation'
require_relative 'validation'
require_relative 'accessors'

class Route
  attr_reader :route_stations, :first_station, :last_station

  include InstanceCounter
  include Validation
  extend Acessors

  @@routes = []

  validate :first_station, :presence
  validate :last_station, :presence

  def initialize(start_point, destination)
    @first_station = start_point
    @last_station = destination
    @route_stations = [start_point, destination]
    validate!
    @@routes << self
    register_instance
  end

  def self.all
    @@routes
    # returns all stations
  end

  def stations
    @route_stations.dup
  end

  def insert_station(station)
    @route_stations.insert(-2, station)
  end

  def delete_station(station)
    return if station.nil?
    return if @route_stations.index(station).zero? || @route_stations.index(station) + 1 == @route_stations.length

    @route_stations.delete(station)
  end

  def next_station(index_of_current_station)
    @route_stations[index_of_current_station + 1]
  end

  def previous_station(index_of_current_station)
    if index_of_current_station > 0
      @route_stations[index_of_current_station - 1]
    end
  end
end
