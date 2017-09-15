class CreateStationAction
  def call
    puts "Enter the name of the Station: "
    station_name = gets.chomp.downcase
    Station.new(station_name) unless station_name.empty?
  end
end

