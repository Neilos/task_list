
module ListHelpers
  
  # returns a hash representing the task
  # e.g. { :task_no => ?, :description  => ?, :due => ?, :complete => ? }
  def find_task(id, session_hash)
    session_hash[:tasks][id]
  end

# To access the tasks in the saved list_order:
# =>  session[:list_order].map {|task_id| session[task_id]}
# {:task_count=>2, :list_order=>["2", "1"], :tasks=>{"1"=>{:task_no=>1, :description=>"Task 1", :due=>#<DateTime: 2013-01-04T00:00:00+00:00 ((2456297j,0s,0n),+0s,2299161j)>, :complete=>true}, "2"=>{:task_no=>2, :description=>"this is task2", :due=>#<DateTime: 2014-02-03T00:00:00+00:00 ((2456692j,0s,0n),+0s,2299161j)>, :complete=>false}}}
  def ordered_tasks(list_order=[], session_hash={})
    new_order_task_hash = {}
    list_order.each {|task_id| new_order_task_hash[task_id] = session_hash[:tasks][task_id] }
    new_order_task_hash
  end

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