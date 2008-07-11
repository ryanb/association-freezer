require File.dirname(__FILE__) + '/../spec_helper'

describe AssociationFreezer::ModelAdditions do
  it "should add enable_association_freezer method to model class" do
    Order.should respond_to(:enable_association_freezer)
  end
  
  it "should add a freeze association method when enabling freezing" do
    Order.enable_association_freezer
    Order.new.should respond_to(:freeze_ship_method)
  end
  
  it "should add an unfreeze association method when enabling freezing" do
    Order.enable_association_freezer
    Order.new.should respond_to(:unfreeze_ship_method)
  end
end
