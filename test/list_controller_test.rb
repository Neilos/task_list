require 'minitest'
require 'minitest/autorun'
require 'mocha/setup'
require 'rack/test'
require_relative '../lib/list_controller'

class ListControllerTest < Minitest::Test
include Rack::Test::Methods

  def app
    ListController.new
  end


  def test_has_a_root_controller_which_returns_the_main_page
    get '/'
    assert last_response.ok?
    assert_includes last_response.body, 'Task List'
  end

  def test_can_delete_a_task
    post '/delete_task'
    assert last_response.ok?
  end

  def test_can_create_tasks
    post '/create_task'
    assert last_response.ok?
  end
<<<<<<< Updated upstream
=======

  def test_can_update_task
    post '/update_task'
    assert last_response.ok?
    assert_equal 1, Task.count
  end
>>>>>>> Stashed changes
end