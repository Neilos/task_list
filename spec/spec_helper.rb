require_relative '../lib/list_controller'
require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'

ENV['RACK_ENV'] = 'test'

Capybara.app = ListController