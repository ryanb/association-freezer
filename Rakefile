require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('association-freezer', '0.1.1') do |p|
  p.summary        = "Freeze an Active Record belongs_to association."
  p.description    = "Freeze an Active Record belongs_to association."
  p.url            = "http://github.com/ryanb/association-freezer"
  p.author         = 'Ryan Bates'
  p.email          = "ryan (at) railscasts (dot) com"
  p.ignore_pattern = ["script/*"]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
