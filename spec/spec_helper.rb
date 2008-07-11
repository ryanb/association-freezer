require 'rubygems'
require 'spec'
require 'active_support'
require 'active_record'
require File.dirname(__FILE__) + '/../lib/association_freezer.rb'

# setup database adapter
ActiveRecord::Base.establish_connection({
  :adapter => "sqlite3", 
  :dbfile => File.dirname(__FILE__) + "/test.sqlite3" 
})

# load models
# there's probably a better way to handle this
require File.dirname(__FILE__) + '/models/order.rb'
CreateOrders.migrate(:up) unless Order.table_exists?
require File.dirname(__FILE__) + '/models/ship_method.rb'
CreateShipMethods.migrate(:up) unless ShipMethod.table_exists?

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
