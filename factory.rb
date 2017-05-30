class Factory
  class << self
    def new(*key, &block)
      Class.new do
        attr_accessor(*key)

        define_method :initialize do |*value|
          key.zip(value).each {|key, value| send("#{key}=", value)}
        end

        def [](key)
          (key.is_a? Numeric) ? instance_variable_get(instance_variables[key]) : instance_variable_get("@#{key}")
        end

        class_eval(&block) if block_given?
      end
    end
  end
end