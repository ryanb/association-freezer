class ShipMethod < ActiveRecord::Base
  has_many :orders
end

class CreateShipMethods < ActiveRecord::Migration
  def self.up
    create_table :ship_methods do |t|
      t.decimal :price
    end
  end
  
  def self.down
    drop_table :ship_methods
  end
end
