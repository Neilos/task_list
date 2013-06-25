
require 'sinatra/base'

class ListController < Sinatra::Base

  configure do
    set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }

    use Rack::Session::Cookie, :key => 'rack.session',
                               :path => '/',
                               :expire_after => 2592000,
                               :secret => 'Charlotte Neil Tim James B Team'
  end

# session = {
#   :task_count => ? ,
#   :tasks      => {
#                   {:id          => ?,
#                   :description  => ?,
#                   :due          => ?,
#                   :complete     =>?}
#                   ,
#                   {:id          => ?,
#                   :description  => ?,
#                   :due          => ?,
#                   :complete     =>?}
#                   }
#           }
# To access the task count in the session:
#   session[:task_count]
# To access all tasks in the session:
#   session[:tasks]
# To access a particular task in the session:
#   use the find_task(:id)

  # def find_task(id)
  # end

  get '/' do
    erb :main
  end

  post '/create_task' do
    # fill this in later

  end

  post '/delete_task' do
    # fill this in later
  end

  post '/update_task' do
    # fill this in later
  end


end