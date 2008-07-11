module AssociationFreezer
  module ModelAdditions
    def enable_association_freezer
      reflect_on_all_associations(:belongs_to).each do |association|
        if column_names.include? "frozen_#{association.name}"
          define_method "freeze_#{association.name}" do
          
          end
        
          define_method "unfreeze_#{association.name}" do
          
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  extend AssociationFreezer::ModelAdditions
end
