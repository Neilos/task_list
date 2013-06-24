
require 'sinatra/base'

class ListController

configure do
  set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }
end

end