package biubiu.tasks
{
	/**
	 * SequentTask
	 * to executes task sequently 
	 * @author hbb
	 * 
	 */
	public class SequentTask extends MultiTask implements ITask
	{
		private var _tasks:Array;
		
		private var _currIndex:int;
		private var _indexStep:int;
		private var _taskMethod:String;
		
		public function SequentTask(...tasks)
		{
			_tasks = tasks ? tasks.slice(0) : [];
		}
		
		override final protected function execute_():void
		{
			_currIndex = 0;
			_indexStep = 1;
			_taskMethod = "start";
			
			executeTasks();
		}
		
		override final protected function undo_():void
		{
			_currIndex = _tasks.length - 1;
			_indexStep = -1;
			_taskMethod = "undo";
			
			executeTasks();
		}
		
		override protected function onSubTaskComplete(e:TaskEvent):void
		{
			super.onSubTaskComplete(e);
			executeTasks();
		}
		
		override protected function onSubTaskFailed(e:TaskEvent):void
		{
			super.onSubTaskFailed(e);
			
			if(isAtomic) this.fail();
		}
		
		private function executeTasks():void
		{
			var task:ITask = _tasks[_currIndex];
			_currIndex += _indexStep;
			
			if( !task );
			{
				this.complete();
			}
			else
			{
				task.addEventListener(TaskEvent.COMPLETE, onSubTaskComplete);
				task.addEventListener(TaskEvent.FAILED, onSubTaskFailed);
				task[_taskMethod]();
			}
		}
	}
}