class CargoCar < Car
  attr_reader :volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
    @free_volume = volume
  end

  def take_up_volume(volume_quantity)
    if @free_volume >= volume_quantity
      @occupied_volume += volume_quantity
      @free_volume -= volume_quantity
      true
    else
      false
    end
  end

  def occupied_volume
    @occupied_volume
  end

  def free_volume
    @free_volume
  end
end
