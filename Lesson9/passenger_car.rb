class PassengerCar < Car
  attr_reader :number_of_places

  def initialize(number_of_places)
    @type = :passenger
    @number_of_places = number_of_places
    @free_places = number_of_places
    @occupied_places = 0
  end

  def take_place
    if @free_places > 0
      @occupied_places += 1
      @free_places -= 1
      true
    else
      false
    end
  end

  def occupied_places_counter
    @occupied_places
  end

  def free_places_counter
    @free_places
  end
end
