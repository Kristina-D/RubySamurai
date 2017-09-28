module Validation

  def valid?
    self.validate!
    rescue RuntimeError => e
      puts e
      false
  end
end