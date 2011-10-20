package biubiu.tasks
{
	import flash.events.Event;

	/**
	 * ParallelTask
	 * @author hbb
	 * 
	 */
	public class ParallelTask extends MultiTask implements ITask
	{
		private var _count:int;
		/**
		 * Constructor 
		 * @param tasks
		 * 
		 */
		public function ParallelTask(...tasks)
		{
			super(tasks);
		}
		
		override final protected function execute_():void
		{
			init("start");
		}
		
		override final protected function undo_():void
		{
			init("undo");
		}
		
		override protected function onSubTaskComplete(e:TaskEvent):void
		{
			super.onSubTaskComplete(e);
			
			if( ++_count == _tasks.length )
			{
				this.complete();
			}
		}
		
		override protected function onSubTaskFailed(e:TaskEvent):void
		{
			super.onSubTaskFailed(e);
			
			if(!isAtomic) return;
			
			for each(var task:ITask in _tasks)
			{
				task.removeEventListener("TaskComplete", onSubTaskComplete);
				task.removeEventListener("TaskFailed", onSubTaskFailed);
			}
			
			this.complete();
		}
		
		protected function init( method:String ):void
		{
			_count = 0;
			
			for each(var task:ITask in _tasks)
			{
				task.addEventListener("TaskComplete", onSubTaskComplete);
				task.addEventListener("TaskFailed", onSubTaskFailed);
				task[method]();
			}
		}
	}
}