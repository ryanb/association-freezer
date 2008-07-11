module AssociationFreezer
  class MethodGenerator

    def initialize(reflection)
      @reflection = reflection
    end
    
    def generate
      # it is very important that we first make sure this hasn't already been done
      # because otherwise it will result in an endless loop the way alias method works.
      return if previously_generated? || !frozen_column_exists?
      
      association = @reflection
        
      generate_method "freeze_#{association.name}" do
        send(association.name, true).freeze
        write_attribute("frozen_#{association.name}", Marshal.dump(send(association.name).attributes))
      end
  
      generate_method "unfreeze_#{association.name}" do
      end
    
      generate_method "#{association.name}_with_frozen_check" do |*args|
        if !instance_variable_defined?("@#{association.name}") || args.first # force reload
          if read_attribute("frozen_#{association.name}")
            association.klass.new(Marshal.load(read_attribute("frozen_#{association.name}")).except('id'))
          else
            send("#{association.name}_without_frozen_check", *args)
          end
        end
        instance_variable_get("@#{association.name}")
      end
      model_class.alias_method_chain association.name, :frozen_check
    end
    
    def previously_generated?
      model_class.instance_methods.include? "freeze_#{@reflection.name}"
    end
    
    def frozen_column_exists?
      model_class.column_names.include? "frozen_#{@reflection.name}"
    end
    
    def model_class
      @reflection.active_record
    end
    
    def generate_method(name, &block)
      model_class.send(:define_method, name, &block)
    end
    
  end
end
