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
    # DatabaseCleaner.clean
  end

  def test_task_can_be_created
    assert_equal 1, Task.count
    Task.create(:name => "Buy milks")
    assert_equal 2, Task.count
  end

end