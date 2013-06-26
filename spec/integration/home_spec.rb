require File.expand_path('../../spec_helper', __FILE__)

describe 'home page', :type => :feature, :js => true do

  it 'allows to create a new task' do
    visit '/'    
    click_button "New Task"
    fill_in "Description", :with => "Buy honey"
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

end