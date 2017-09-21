module InstanceCounter

  class << self
    def included(base)
      base.extend ClassMethods
      base.class_variable_set(:@@counter, 0)
    end
  end

  module ClassMethods
    def instances
     	#возвращает кол-во экземпляров данного класса
      # all.size
      class_variable_get(:@@counter)
    end
  end

private
  def register_instance
    self.class.class_variable_set(:@@counter, self.class.class_variable_get(:@@counter) + 1)
  end
end