require_relative 'store'

class CreateRouteAction
  attr_reader :station_names_array

  def call
    puts "Enter name of the 1st station: "
    first_station_name = gets.chomp.downcase

    puts "Enter name of the last station: "
    last_station_name = gets.chomp.downcase

    [first_station_name, last_station_name]
  end
end

