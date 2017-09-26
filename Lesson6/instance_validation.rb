module Validation

  def self.included(base)
 #  base.include InstanceMethods
    base.send :include, InstanceMethods
    base.class_variable_set(:@@e, 0)
  end
  
  module InstanceMethods
    def valid?
      self.validate!
      rescue RuntimeError => e
        puts e
        false
      end
    end
end