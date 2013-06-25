require 'minitest'
require 'minitest/autorun'
require 'rack/test'
require_relative './test_helper'
require_relative '../lib/task'

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

end