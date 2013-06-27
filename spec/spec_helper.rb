require 'mongoid'
require 'database_cleaner'
require 'rspec'
require 'capybara/rspec'
ENV['RACK_ENV'] = 'test'

require_relative '../lib/list_controller'

Capybara.app = ListController


module IntegrationTestHelper

  def create_new_task(task_no, description, due, completed=false)
    click_button "New Task"
    fill_in "Task Number", :with => task_no
    fill_in "Description", :with => description
    fill_in "Due", :with => due
    page.check('completed') if completed
    click_button "Create Task"
    within("#sortable") do     
      page.should have_content(description)
    end
  end
end