require File.expand_path('../../spec_helper', __FILE__)

describe 'home page', :type => :feature do

  it 'allows to create a new task' do
    visit '/'
    page.should have_content('New Task')
  end

end