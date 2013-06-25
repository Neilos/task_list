require 'mongoid'
require 'database_cleaner'
ENV['RACK_ENV'] = 'test'
Mongoid.load! './config/mongoid.yml'
