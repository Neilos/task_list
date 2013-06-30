require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'rack/test'
require_relative '../lib/list_helpers'
require_relative '../lib/task'
require 'mongoid'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'


class ListHelpersTest < Minitest::Test
include ListHelpers

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end


  def test_find_all_task_ids
    Task.create(:task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2080,9,8),
                :completed => false )
    all_tasks = find_all_task_ids
    assert_equal 1, all_tasks.count
  end

  def test_find_all_tasks
    Task.create(:task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2080,9,8),
                :completed => false )
    Task.create(:task_no => 2, 
                :description => "Buy cheese", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    my_tasks = find_all_tasks
    assert_equal 2, my_tasks.count
  end

end
