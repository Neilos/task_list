require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require_relative '../lib/task'
require 'mongoid'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

class TaskTest < Minitest::Test

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_task_can_be_created
    assert_equal 0, Task.count
    Task.create(:task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2001,2,3),
                :completed => false )
    assert_equal 1, Task.count
  end

  def test_task_can_be_editied
    task1 = Task.create(:task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2080,9,8),
                :completed => false )
    assert_equal 1, Task.count
    task1.update_attributes!(:task_no => 2,
                :description => "Buy pie",
                :due => DateTime.new(2013,12,25) )
    assert_equal 2, task1.task_no
    assert_equal "Buy pie", task1.description
    assert_equal 1, Task.count
  end


end