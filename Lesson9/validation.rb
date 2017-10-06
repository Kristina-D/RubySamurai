module Validation
  def self.included(base)
    base.extend ClassMethods
    base.include InstanceMethods
    base.class_variable_set(:@@presence_verifications, [])
    base.class_variable_set(:@@format_verifications, [])
    base.class_variable_set(:@@type_verifications, [])
    base.class_variable_set(:@@kinds_verifications, [])
  end

  module ClassMethods
    def validate(variable, validation_type, *attrs)
      attribute = attrs
      variable_name = variable.to_s

      if validation_type == :presence
        # check that attribute is not empty
        class_variable_set(:@@presence_verifications, class_variable_get(:@@presence_verifications) << [variable_name, "#{variable_name.capitalize} can't be empty. Please try again."])
        # define_method (var_name) { var_name.empty? raise error}
      elsif validation_type == :format
        class_variable_set(:@@format_verifications, class_variable_get(:@@format_verifications) << [variable_name, attribute[0], "#{variable_name.capitalize} has invalid format. Please try again."])
      elsif validation_type == :type
        class_variable_set(:@@type_verifications, class_variable_get(:@@type_verifications) << [attribute, "#{variable_name.capitalize} class is incorrect. Please try again."])
      elsif validation_type == :kinds
        class_variable_set(:@@kinds_verifications, class_variable_get(:@@kinds_verifications) << [variable_name, attribute, "#{variable_name.capitalize} is incorrect. The allowed #{variable_name} values are: #{attribute.map(&:to_s).join(', ')}. Please try again."])
      end
    end
  end

  module InstanceMethods
    def presence_verification
      self.class.class_variable_get(:@@presence_verifications)
    end

    def format_verification
      self.class.class_variable_get(:@@format_verifications)
    end

    def kinds_verification
      self.class.class_variable_get(:@@kinds_verifications)
    end

    def type_verification
      self.class.class_variable_get(:@@type_verifications)
    end

    def validate!
      presence_verification.each do |variable_name, error|
        variable = instance_variable_get('@' + variable_name)

        action = if self.class == Route
                   'nil?'
                 else
                   'empty?'
                 end

        raise error if variable.send(action)
      end

      format_verification.each do |variable_name, format, error|
        variable = instance_variable_get('@' + variable_name)
        raise error if variable !~ format
      end

      type_verification.each do |attribute, error|
        raise error if self.class != attribute[0]
      end

      kinds_verification.each do |variable_name, kinds, error|
        variable = instance_variable_get('@' + variable_name)
        kinds_array_length = kinds.length
        i = 0
        no_match = true

        while i < kinds_array_length
          if variable == kinds[i].to_s
            no_match = false
            break
          else
            i += 1
          end
        end
        raise error if no_match
      end
      true
    end

    def valid?
      validate!
    rescue RuntimeError => e
      puts e
      false
    end
  end
end
