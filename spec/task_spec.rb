require_relative 'spec_helper'
require_relative '../lib/task'

describe 'Task' do

	before do
		DatabaseCleaner.start
	end

	after do
		DatabaseCleaner.clean
	end

	it 'can be created' do
		Task.count.should eq(0)
		Task.create({:task => 'buy milk'})
		Task.count.should eq(1)
	end
	
end