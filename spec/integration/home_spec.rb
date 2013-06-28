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
    fill_in "Due", :with => "23-05-2013"
    page.check('create_completed')
    click_button "Create Task"
    within("#sortable") do     
      page.should have_content("Buy honey")
    end
  end

  it 'displays tasks that were created in a previous visit' do
    visit '/'
    create_new_task(1, "buy milk", "15-05-2013", true)
    create_new_task(2, "get job", "23-05-2013")
    create_new_task(3, "write a book", "26-08-2013", false)
    visit '/'
    within("#sortable") do     
      page.should have_content("buy milk")
      page.should have_content("get job")
      page.should have_content("write a book")
    end
    page.body.index("buy milk").should < page.body.index("write a book")
  end

  it 'maintains the order of the tasks as set in a previous page visit' do
    visit '/'
    create_new_task(1, "buy milk", "15-05-2013", true)
    create_new_task(2, "get job", "23-05-2013")
    create_new_task(3, "write a book", "26-08-2013", false)
    task1 = Task.find_by(description: "buy milk")
    task2 = Task.find_by(description: "get job")
    java_script1 = %Q|function swapNodes(a, b) {
                      var aparent = a.parentNode;
                      var asibling = a.nextSibling === b ? a : a.nextSibling;
                      b.parentNode.insertBefore(a, b);
                      aparent.insertBefore(b, asibling);}|
    page.execute_script(java_script1)
    java_script2 = %Q|swapNodes(document.getElementById("#{task1.id}"), document.getElementById("#{task2.id}"));|
    page.execute_script(java_script2)
    page.body.index("get job").should be < page.body.index("buy milk")
    visit '/'
    page.body.index("get job").should be < page.body.index("buy milk")
  end

  describe "a task on the page" do
    
    describe "update button" do

      it 'allows to update a task' do
        visit '/'
        create_new_task(1, "buy milk", "15-05-2013", true)
        click_button "Edit"
        fill_in "Description", :with => "Buy cheese"
        fill_in "Due", :with => "23-05-2013"
        page.check("create_completed")
        click_button "Update Task"
        within("#sortable") do     
          page.should have_content("Buy cheese")
        end
      end
    end

    describe "delete button" do

      it 'deletes an existing task' do
        visit '/'
        create_new_task(1, "buy milk", "15-05-2013", true)
        create_new_task(2, "get job", "23-05-2013")
        first(:button, 'Delete').click
        within("#sortable") do     
          page.should_not have_content("buy milk")
        end
      end

    end
  end

end