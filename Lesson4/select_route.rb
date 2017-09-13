require_relative 'store'

class SelectRoute
  attr_reader :selected_route_number

  def call
    puts "select the number of your route: "
    selected_route_number = gets.chomp
  end
end

