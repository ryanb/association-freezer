class Order < ActiveRecord::Base
  belongs_to :ship_method
end

class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :ship_method_id
      t.binary  :frozen_ship_method
    end
  end
  
  def self.down
    drop_table :orders
  end
end
