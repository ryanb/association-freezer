require 'rubygems'
require 'rake'
 
begin
  require 'echoe'

  Echoe.new('association-freezer', '0.1.0') do |p|
    p.summary        = "Freeze a belongs_to association."
    p.description    = "Freeze a belongs_to association."
    p.url            = "http://github.com/ryanb/association-freezer"
    p.author         = 'Ryan Bates'
    p.email          = "ryan (at) railscasts (dot) com"
    p.ignore_pattern = ["script/*"]
  end

rescue LoadError => boom
  puts "You are missing a dependency required for meta-operations on this gem."
  puts "#{boom.to_s.capitalize}."
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
