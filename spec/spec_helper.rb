require_relative '../lib/list_controller'
require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'
Mongoid.load! File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml')

Capybara.app = ListController