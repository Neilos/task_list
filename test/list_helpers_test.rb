require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'rack/test'
require_relative '../lib/list_helpers'
require_relative './test_helper'
require_relative '../lib/task'



class ListHelpersTest < Minitest::Test
include ListHelpers

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_find_task
    session_hash = {
      :task_count => 2 ,
      :list_order  => ['2', '1'],
      :tasks      => {'1' => {:task_no      => 1,
                               :description  => "Task 1",
                               :due          => DateTime.new(2013,1,4),
                               :complete     => true }, 
                      '2' => {:task_no     => 2,
                              :description  => "this is task2",
                              :due          => DateTime.new(2014,2,3),
                              :complete     => false }
                      }
    }
    expected_task = {:task_no => 2,:description => "this is task2",:due => DateTime.new(2014,2,3), :complete => false}
    assert_equal expected_task, find_task('2', session_hash)
  end

  def test_ordered_task
        session_hash = {
      :task_count => 2 ,
      :list_order  => ['2', '1'],
      :tasks      => {'1' => {:task_no      => 1,
                               :description  => "Task 1",
                               :due          => DateTime.new(2013,1,4),
                               :complete     => true }, 
                      '2' => {:task_no     => 2,
                              :description  => "this is task2",
                              :due          => DateTime.new(2014,2,3),
                              :complete     => false }
                      }
    }
    expected_list = {'2' => {:task_no     => 2,
                              :description  => "this is task2",
                              :due          => DateTime.new(2014,2,3),
                              :complete     => false },
                    '1' => {:task_no      => 1,
                             :description  => "Task 1",
                             :due          => DateTime.new(2013,1,4),
                             :complete     => true }
                    }
    assert_equal expected_list, ordered_tasks(session_hash[:list_order], session_hash)
  end

  def test_find_all_task_ids
    Task.create(:task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2080,9,8),
                :completed => false )
    #add method here and remove:
    #description = Task.first.description
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
