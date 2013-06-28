require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'rack/test'
require_relative './test_helper'
require_relative '../lib/list_controller'

class ListControllerTest < Minitest::Test
include Rack::Test::Methods

  def app
    ListController.new
  end

  def setup
    DatabaseCleaner.start
  end

  def teardown
    DatabaseCleaner.clean
  end

  def test_has_a_root_controller_which_returns_the_main_page
    task1 = Task.create!(
                :list_position => 3,
                :task_no => 3, 
                :description => "get job", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    task2 = Task.create!(
                :list_position => 2,
                :task_no => 2, 
                :description => "Buy cheese", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Task List'
    assert_operator last_response.body.index("Buy cheese"), :<, last_response.body.index("get job")
  end

  def test_can_delete_a_task
    assert_equal 0, Task.count
    task_to_delete = Task.create!(
                :list_position => 1,
                :task_no => 1, 
                :description => "Buy milk", 
                :due => DateTime.new(2080,9,8),
                :completed => false )
    assert_equal 1, Task.count
    task_to_keep = Task.create!(
                :list_position => 2,
                :task_no => 2, 
                :description => "Buy cheese", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    assert_equal 2, Task.count
    post '/delete_task', :id => task_to_delete.id
    assert last_response.ok?
    assert_equal 1, Task.count
  end

  def test_update_task_positions
    task1 = Task.create!(
                :list_position => 1,
                :task_no => 3, 
                :description => "get job", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    task2 = Task.create!(
                :list_position => 2,
                :task_no => 2, 
                :description => "Buy cheese", 
                :due => DateTime.new(2080,10,8),
                :completed => false )
    params_hash = { task1.id => "3" , task2.id => "4" }
    post '/update_task_positions', params_hash
    assert last_response.ok?
    task1.reload
    task2.reload
    assert_equal 3, task1.list_position
    assert_equal 4, task2.list_position
  end

  def test_can_update_task
    skip
    post '/update_task'
  end

  def test_can_create_tasks
    assert_equal 0, Task.count
    post '/create_task', {
                :list_position => 1,
                :task_no => 1, 
                :description => "Buy milk", 
                :due => '2013-02-25',
                :completed => false}
    assert last_response.ok?
    assert_equal 1, Task.count
  end
end