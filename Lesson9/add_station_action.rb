class AddStationAction
  def add_station
    puts 'Enter the name of the Station: '
    station_name = gets.chomp.downcase

    if station_name.empty?
      puts 'Station name must be entered. Please try again.'
    else
      station = Station.new(station_name)
      puts "New station #{station.station_name} is created"
      print_stations_list
    end
  end
end
