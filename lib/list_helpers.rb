
module ListHelpers

  def find_all_task_ids
    @all_task_ids = []
    Task.each { |task| @all_task_ids << task.id }
    @all_task_ids
  end

  def find_all_tasks
    @all_tasks = []
    find_all_task_ids.each { |task_id| @all_tasks << Task.find(task_id)}
    @all_tasks
  end

end