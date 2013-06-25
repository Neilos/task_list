require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require_relative '../lib/list_helpers'

class ListHelpersTest < Minitest::Test
include ListHelpers

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
end
