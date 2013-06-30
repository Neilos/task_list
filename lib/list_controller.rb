
require 'sinatra/base'
require 'mongoid'
require 'moped'
require_relative './list_helpers'
require_relative './task'

class ListController < Sinatra::Base
include ListHelpers

Mongoid.load! File.join(File.dirname(__FILE__), '..', 'config', 'mongoid.yml')


  configure do
    set :root, Proc.new { File.join(File.dirname(__FILE__), "../") }
    use Rack::Session::Cookie, 
      :key => 'rack.session',
      :path => '/',
      :expire_after => 2592000,
      :secret => 'Charlotte Neil Tim James B Team'
  end


  get '/' do
    @tasks = find_all_tasks
    @tasks.sort!{|task_x, task_y| task_x.list_position <=> task_y.list_position }
    erb :main
  end

  post '/update_task_positions' do
    params_hash = params
    params_hash.each do |id, position|
      task = Task.find(id.to_s)
      task.update_attributes!(list_position: position)
    end
  end

  post '/create_task' do
    new_task = Task.create!(
      :list_position => params[:list_position],
      :task_no => params[:task_no],
      :description => params[:description],
      :due => DateTime.parse(params[:due]),
      :completed => params[:completed]
      )
    { :task_id => new_task.id,  
      :list_position => new_task.list_position,
      :task_no => new_task.task_no, 
      :description => new_task.description, 
      :due => new_task.due, 
      :completed => new_task.completed
    }.to_json
  end


  post '/delete_task' do
    task_to_delete = Task.find(params[:id])
    task_to_delete.destroy
    { :task_id => task_to_delete.id }.to_json
  end


  post '/update_task' do
    task_to_update = Task.find(params[:id])
    task_to_update.update_attributes!(:task_no => params[:task_no],
                :description => params[:description],
                :due => params[:due],
                :completed => params[:completed]
                )
    { :task_id => task_to_update.id,  
      :task_no => task_to_update.task_no, 
      :description => task_to_update.description, 
      :due => task_to_update.due, 
      :completed => task_to_update.completed
    }.to_json
  end


end