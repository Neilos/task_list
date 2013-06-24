
require 'sinatra/base'

class ListController < Sinatra::Base

configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }
end

  get '/' do
    
    erb :main
  end

end