package biubiu.tasks
{
	import flash.events.Event;

	/**
	 * ParallelTask
	 * to executes task parallely 
	 * @author hbb
	 * 
	 */
	public class ParallelTask extends AbstractTask implements ITask
	{
		private var _tasks:Array;
		private var _count:int;
		public function ParallelTask(...tasks)
		{
			_tasks = tasks ? tasks.slice(0) : [];
		}
		
		/**
		 * add a task 
		 * @param task
		 */
		public function add( task:ITask ):ParallelTask
		{
			if(_tasks.indexOf( task ) > -1) return;
			_tasks.push( task );
			return this;
		}
		
		override final protected function execute_():void
		{
			var i:int, n:int;
			var task:ITask;
			
			_count = 0;
			
			for( i=0,n=_tasks.length; i<n; ++i)
			{
				task = _tasks[i];
				task.broadcaster.addEventListener("TaskComplete", onSubTaskComplete);
				task.start();
			}
		}
		
		protected function onSubTaskComplete(e:Event):void
		{
			var task:ITask = e.target as ITask;
			task.broadcaster.removeEventListener("TaskComplete", onSubTaskComplete);
			
			if( ++_count == _tasks.length )
			{
				this.complete();
			}
		}
	}
}