module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set(:@@verifications, [])
    #Не нужно валидации хранить отдельно,
    #cделай общий массив и храни там все валидации, например в виде хешей.
  end

  module ClassMethods
    def validate(variable, method, *attrs)
      class_variable_set(:@@verifications, class_variable_get(:@@verifications) << { "variable_name" => variable.to_s, "verification_method" => method.to_s, "attributes" => attrs})
    end
  end

  module InstanceMethods
    def verifications
      self.class.class_variable_get(:@@verifications)
    end

    def validate_presence(variable, error)
      raise error if variable.empty?
    end
    
    def validate_format(variable, a_format, error)
      raise error if variable !~ a_format
    end

    def validate_type(given_class, attribute_class, error)
      raise error if given_class != attribute_class
    end

    def validate!
      verifications.each do |value|
        variable = instance_variable_get('@' +  value["variable_name"] )
        
        send :validate_presence, variable, "#{value["variable_name"].capitalize} can't be empty." if value["verification_method"] == "presence"
        send :validate_format, variable, value["attributes"][0], "#{value["variable_name"].capitalize} has incorrect format" if value["verification_method"] == "format"
        send :validate_type, self.class, value["attributes"][0], "The attribute class doesn't correspond to the given class" if value["verification_method"] == "type"
      end
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts e
      false
    end
  end
end

