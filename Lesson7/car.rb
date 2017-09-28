require_relative 'manufacturer'

class Car
  attr_reader :type
  
  include Manufacturer

  def take(car, parameter)
    if car.type == :cargo
      take_up_volume(parameter)
    elsif car.type == :passenger
      car.take_place
    end
  end

end