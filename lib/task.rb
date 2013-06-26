require 'mongoid'

class Task

  include Mongoid::Document

  field :task_no, type: Fixnum
  field :description, type: String
  field :due, type: DateTime
  field :completed, type: Boolean
end