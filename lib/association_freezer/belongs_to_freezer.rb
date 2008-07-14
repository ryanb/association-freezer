module AssociationFreezer
  class BelongsToFreezer
    def initialize(owner, reflection)
      @owner = owner
      @reflection = reflection
    end
    
    def freeze
      self.frozen_data = Marshal.dump(nonfrozen.attributes) if nonfrozen
    end
    
    def unfreeze
      @frozen = nil
      self.frozen_data = nil
    end
    
    def fetch(*args)
      frozen || nonfrozen(*args)
    end
    
    def frozen?
      frozen_data
    end
    
    private
    
    def frozen
      @frozen ||= load_frozen if frozen?
    end
    
    def load_frozen
      target_class.new(Marshal.load(frozen_data).except('id')).freeze
    end
    
    def nonfrozen(*args)
      @owner.send("#{name}_without_frozen_check", *args)
    end
    
    def frozen_data=(data)
      @owner.write_attribute("frozen_#{name}", data)
    end
    
    def frozen_data
      @owner.read_attribute("frozen_#{name}")
    end
    
    def target_class
      @reflection.klass
    end
    
    def name
      @reflection.name
    end
  end
end
