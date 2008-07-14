module AssociationFreezer
  class BelongsToFreezer
    def initialize(owner, reflection)
      @owner = owner
      @reflection = reflection
    end
    
    def freeze
      freeze_to_db(Marshal.dump(nonfrozen.attributes))
    end
    
    def unfreeze
      # TODO
    end
    
    def fetch(*args)
      frozen(*args) || nonfrozen(*args)
    end
    
    def frozen(force_reload = false)
      if @frozen && !force_reload
        @frozen
      elsif frozen_in_db
        @frozen = target_class.new(Marshal.load(frozen_in_db).except('id')).freeze
      end
    end
    
    private
    
    def nonfrozen(*args)
      @owner.send("#{name}_without_frozen_check", *args)
    end
    
    def freeze_to_db(data)
      @owner.write_attribute("frozen_#{name}", data)
    end
    
    def frozen_in_db
      @owner.read_attribute("frozen_#{name}")
    end
    
    def attribute_name
      "frozen_#{name}"
    end
    
    def target_class
      @reflection.klass
    end
    
    def name
      @reflection.name
    end
  end
end
