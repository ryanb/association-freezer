require File.dirname(__FILE__) + '/../spec_helper'

describe AssociationFreezer::ModelAdditions do
  it "should add enable_association_freezer method to model class" do
    Order.should respond_to(:enable_association_freezer)
  end
end
