
require 'sinatra/base'

class ListController < Sinatra::Base

configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }
end

  get '/' do
    erb :main
  end

  post '/delete_task' do
    # fill this in later
  end

  post '/update_task' do
    # fill this in later
  end

  post '/create_task' do
    # fill this in later
  end
end