package biubiu.tasks
{
	import flash.events.Event;

	/**
	 * SequentTask
	 * to executes task sequently 
	 * @author hbb
	 * 
	 */
	public class SequentTask extends AbstractTask implements ITask
	{
		private var _tasks:Array;
		
		public function SequentTask(...tasks)
		{
			// reverse
			_tasks = tasks ? tasks.slice(0) : [];
		}
		
		/**
		 * add a task 
		 * @param task
		 */
		public function add( task:ITask ):SequentTask
		{
			if(_tasks.indexOf( task ) > -1) return;
			_tasks.push( task );
			return this;
		}
		
		override final protected function execute_():void
		{
			var task:ITask;
			
			if( _tasks.length == 0 )
			{
				this.complete();
			}
			else
			{
				task = _tasks.shift();
				task.broadcaster.addEventListener("TaskComplete", onSubTaskComplete);
				task.start();
			}
		}
		
		protected function onSubTaskComplete(e:Event):void
		{
			var task:ITask = e.target as ITask;
			task.broadcaster.removeEventListener("TaskComplete", onSubTaskComplete);
			this.execute_();
		}
	}
}