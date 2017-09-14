class Route
  attr_reader :route_stations
  
  def initialize(start_point, destination)
    @route_stations = [start_point, destination]
  end

  def stations
    @route_stations.dup
  end

  def insert_station(station)
    @route_stations.insert(-2, station)
  end

  def delete_station(station)
    return if station.nil?
    return if @route_stations.index(station) == 0 || @route_stations.index(station) + 1 == @route_stations.length
    
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