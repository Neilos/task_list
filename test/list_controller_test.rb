require 'minitest'
require 'minitest/autorun'
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


end