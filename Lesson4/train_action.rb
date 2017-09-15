class CreateTrainAction
  attr_reader :train

  def call
      puts "Please enter the train number: "
      number = gets.chomp

      puts "Please enter the train type (enter cargo or passenger): "
      type = gets.chomp

      if type == "passenger"
        @train = PassengerTrain.new(number, type)
      elsif type == "cargo"
        @train = CargoTrain.new(number, type)
      end

      @train
  end
end

