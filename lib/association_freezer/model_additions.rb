module AssociationFreezer
  module ModelAdditions
    # REFACTORME !!!
    def enable_association_freezer
      reflect_on_all_associations(:belongs_to).each do |reflection|
        MethodGenerator.new(reflection).generate
      end
    end
  end
end

class ActiveRecord::Base
  extend AssociationFreezer::ModelAdditions
end
