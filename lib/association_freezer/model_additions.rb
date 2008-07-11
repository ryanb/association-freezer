module AssociationFreezer
  module ModelAdditions
    def enable_association_freezer
    end
  end
end

class ActiveRecord::Base
  extend AssociationFreezer::ModelAdditions
end
