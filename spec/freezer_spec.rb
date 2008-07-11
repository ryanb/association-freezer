require File.dirname(__FILE__) + '/spec_helper'

describe Order do
  it "respond to enable_association_freezer" do
    Order.should respond_to(:enable_association_freezer)
  end
  
  describe "with freezer" do
    before(:each) do
      Order.enable_association_freezer
    end
    
    it "should add a freeze association method when enabling freezing" do
      Order.new.should respond_to(:freeze_ship_method)
    end
  
    it "should add an unfreeze association method when enabling freezing" do
      Order.new.should respond_to(:unfreeze_ship_method)
    end
  end
end
