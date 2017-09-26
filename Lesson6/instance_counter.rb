module InstanceCounter

  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set(:@@counter, 0)
  end


  module ClassMethods
    def instances
     	#возвращает кол-во экземпляров данного класса
      # all.size
      class_variable_get(:@@counter)
    end
  end

private
  module InstanceMethods
    def register_instance
      self.class.class_variable_set(:@@counter, get_counter + 1)
    end

    def get_counter
      self.class.class_variable_get(:@@counter)
    end
  end
end