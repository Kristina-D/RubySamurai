require_relative 'manufacturer'

class Car
  attr_reader :type
  
  include Manufacturer

end