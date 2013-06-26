require 'mongoid'
require 'database_cleaner'
ENV['RACK_ENV'] = 'test'
Mongoid.load! File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml')
