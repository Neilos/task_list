require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'
ENV['RACK_ENV'] = 'test'

require_relative '../lib/list_controller'

Capybara.app = ListController
