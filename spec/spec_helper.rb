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

Spec::Runner.configure do |config|
  config.mock_with :mocha
end
