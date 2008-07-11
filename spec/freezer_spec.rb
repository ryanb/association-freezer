require File.dirname(__FILE__) + '/spec_helper'

describe Order do
  it "respond to enable_association_freezer" do
    Order.should respond_to(:enable_association_freezer)
  end
  
  describe "with freezer" do
    before(:each) do
      Order.enable_association_freezer
      @order = Order.new
    end
    
    it "should add a freeze association method when enabling freezing" do
      @order.should respond_to(:freeze_ship_method)
    end
  
    it "should add an unfreeze association method when enabling freezing" do
      @order.should respond_to(:unfreeze_ship_method)
    end
  
    it "should not add freeze/unfreeze methods to cart association since it doesn't have a frozen column" do
      @order.should_not respond_to(:freeze_cart)
      @order.should_not respond_to(:unfreeze_cart)
    end
    
    it "should not freeze association without specifying" do
      @order.ship_method = ShipMethod.create!
      @order.ship_method(true).should_not be_frozen
    end
    
    describe "when freezing association" do
      before(:each) do
        @ship_method = ShipMethod.create!(:price => 5)
        @order.ship_method = @ship_method
        @order.freeze_ship_method
      end
      
      it "should freeze associated model" do
        @order.ship_method.should be_frozen
      end
      
      it "should not freeze original object" do
        @ship_method.should_not be_frozen
      end
      
      it "should still consider model frozen after reload" do
        @order.ship_method(true).should be_frozen
      end
      
      it "should ignore changes to associated model" do
        @ship_method.update_attribute(:price, 8)
        @order.ship_method(true).price.should == 5
      end
    end
  end
end
