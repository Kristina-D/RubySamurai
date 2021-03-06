class CargoCar < Car
  attr_reader :volume

  def initialize(volume)
    @type = :cargo
    @volume = volume
    @occupied_volume = 0
  end

  def take_up_volume(volume_quantity)
    if @volume - @occupied_volume >= volume_quantity
      @occupied_volume += volume_quantity
      true
    else
      false
    end
  end

  attr_reader :occupied_volume

  def free_volume
    @volume - @occupied_volume
  end
end
