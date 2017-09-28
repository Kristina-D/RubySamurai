class CargoCar < Car
  attr_reader :volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def take_up_volume(volume_quantity)
    if @volume - volume_quantity > 0
      @occupied_volume += volume_quantity
      true
    else
      false
    end
  end

  def occupied_volume
    @occupied_volume
  end

  def free_volume
    @volume - @occupied_volume
  end
end
