require File.expand_path('../../spec_helper', __FILE__)

RSpec.configure do |c|
  c.include IntegrationTestHelper
end

describe 'home page', :type => :feature, :js => true do

  before(:each) do
    DatabaseCleaner.start
  end

  after(:each) do
    DatabaseCleaner.clean
  end


  it 'allows to create a new task' do
    visit '/'    
    click_button "New Task"
    fill_in "Task Number", :with => "1"
    fill_in "Description", :with => "Buy honey"
    page.check('completed')
    click_button "Create Task"
    within(".to-do-items") do     
      page.should have_content('Buy honey')
    end
  end

  it 'allows to update a task' do
    visit '/'    
    click_button "Edit"
    fill_in "Description", :with => "Buy cheese"
    click_button "Update Task"
    within(".to-do-items") do     
      page.should have_content('Buy cheese')
    end
  end

  it 'displays tasks that were created in a previous visit' do
    visit '/'
    create_new_task(1, "buy milk", "15-05-2013", true)
    create_new_task(2, "get job", "23-05-2013")
    create_new_task(3, "write a book", "26-08-2013", false)
    visit '/'
    within(".to-do-items") do     
      page.should have_content("buy milk")
      page.should have_content("get job")
      page.should have_content("write a book")
    end
  end


end