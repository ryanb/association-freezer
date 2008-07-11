module AssociationFreezer
  module ModelAdditions
    def enable_association_freezer
      reflect_on_all_associations(:belongs_to).each do |association|
        
        # it is very important that we first make sure this hasn't already been done
        # because otherwise it will result in an endless loop the way alias method works.
        unless instance_methods.include? "freeze_#{association.name}"
          
          if column_names.include? "frozen_#{association.name}"
            define_method "freeze_#{association.name}" do
              send(association.name, true)
            end
        
            define_method "unfreeze_#{association.name}" do
              
            end
          
          
            define_method "#{association.name}_with_frozen_check" do |*args|
              if !instance_variable_defined?("@#{association.name}") || args.first # force reload
                send("#{association.name}_without_frozen_check", *args).freeze
              end
              instance_variable_get("@#{association.name}")
            end
            alias_method_chain association.name, :frozen_check
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  extend AssociationFreezer::ModelAdditions
end
