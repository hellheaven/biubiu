package biubiu.tasks
{
	/**
	 * MultiTask also is an abstract class that execute a bunch of tasks.
	 * it must to use a sub class one of SequentTask and ParallelTask.
	 * 
	 * @author hbb
	 */
	public class MultiTask extends AbstractTask implements ITask
	{
		protected var _tasks:Array;
		
		/**
		 * Constructor 
		 * @param tasks, bunch of tasks
		 * 
		 */
		public function MultiTask(...tasks)
		{
			super();
			
			_tasks = tasks ? tasks.slice(0) : [];
		}
		
		/**
		 * The concept of atomic comes from database system
		 * 
		 * Determines if the tasks are interdependant.  For example: if one task in a sequence fails
		 * then the whole batch fails and exits immediately.  If one task in the parallel fails, all will 
		 * finish executing, but the batch task itself will fail
		 * 
		 * isAtomic = true : This means they are NOT dependant on each other
		 * isAtomic = false : This means that they ARE dependant on each other
		 */		
		public var isAtomic:Boolean = false;
		
		/**
		 * add the task into bunch 
		 * @param task
		 * @return object self to link-style programming
		 */
		public function addTask( task:ITask ):MultiTask
		{
			_tasks[_tasks.length] = task;
			return this;
		}
		
		/**
		 * add a bunch of tasks
		 * @param tasks
		 * @return object self to link-style programming
		 */
		public function addTasks(...tasks):MultiTask
		{
			for(var i:int, n:int = tasks.length; i < n; ++i)
			{
				addTask(tasks[i]);
			}
			return this;
		}
		
		protected function onSubTaskComplete(e:TaskEvent):void
		{
			var task:ITask = e.target as ITask;
			task.removeEventListener(TaskEvent.COMPLETE, onSubTaskComplete);
			task.removeEventListener(TaskEvent.FAILED, onSubTaskFailed);
		}
		
		protected function onSubTaskFailed(e:TaskEvent):void
		{
			var task:ITask = e.target as ITask;
			task.removeEventListener(TaskEvent.COMPLETE, onSubTaskComplete);
			task.removeEventListener(TaskEvent.FAILED, onSubTaskFailed);
		}
	}
}