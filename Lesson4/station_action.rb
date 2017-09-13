require_relative 'store'

class CreateStationAction
  attr_reader :station

  def call
    puts "Enter the name of the Station: "
    station_name = gets.chomp.downcase
    if station_name.empty? == false
      @station = Station.new(station_name)
    else
  	  @station = nil
    end
    @station
  end
end

