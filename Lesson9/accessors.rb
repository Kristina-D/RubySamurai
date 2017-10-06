module Acessors
  def attr_accessor_with_history(*vars)
    vars.each do |var|
      var_name = "@#{var}".to_sym
      var_array = []
      define_method (var) { instance_variable_get(var_name) }
      define_method ("#{var}=".to_sym) do |value|
        instance_variable_set(var_name, value)
        var_array << value
      end
      define_method ("#{var}_history".to_sym) do
        puts "The values of #{var} variable :"
        puts var_array.empty? ? 'No values' : var_array
      end
    end
  end

  def strong_attr_accessor(var, selected_class)
    var_name = "@#{var}".to_sym
    define_method (var) { instance_variable_get(var_name) }
    define_method ("#{var}=".to_sym) do |value|
      if value.class == selected_class
        instance_variable_set(var_name, value)
      else
        raise "The class doesn't correspond to the variable. Please try again."
      end
    end
  end
end
