
require 'sinatra/base'
require 'mongoid'
require_relative './list_helpers'
require_relative './task'

class ListController < Sinatra::Base
include ListHelpers

Mongoid.load! File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml')

  configure do
    set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }

    use Rack::Session::Cookie, :key => 'rack.session',
                               :path => '/',
                               :expire_after => 2592000,
                               :secret => 'Charlotte Neil Tim James B Team'
  end

# session = {
#   :task_count => ? ,
#   :list_order  => [:-2, :-1]
#   :tasks      => {
#                   :-1 => {:task_no      => ?,
#                            :description  => ?,
#                            :due          => ?,
#                            :complete     => ?
#                            }
#                   ,
#                   :-2 => {:task_no     => ?,
#                           :description  => ?,
#                           :due          => ?,
#                           :complete     =>?}
#                           }
#           }
# To access the task count in the session:
#   session[:task_count]
# To access all tasks in the session:
#   session[:tasks]
# To access a particular task in the session:
#   use the find_task(:id)
# To access the tasks in the saved list_order:
# =>  session[:list_order].map {|task_id| session[task_id]}
  


  get '/' do
    erb :main
  end

  post '/create_task' do
    Task.create(:task_no => params[:task_no],
                :description => params[:description],
                :due => params[:due],
                :completed => params[:completed]
                )
  end

  post '/delete_task' do
    # fill this in later
  end

  post '/update_task' do
    # fill this in later
  end

end