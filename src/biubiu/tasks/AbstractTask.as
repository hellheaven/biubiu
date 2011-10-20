package biubiu.tasks
{
	import flash.events.EventDispatcher;
	
	[Event(name="TaskStart", type="biubiu.events.TaskEvent")]
	
	[Event(name="TaskExecute", type="biubiu.events.TaskEvent")]
	
	[Event(name="TaskComplete", type="biubiu.events.TaskEvent")]
	
	[Event(name="TaskFailed", type="biubiu.events.TaskEvent")]
	
	[Event(name="TaskUndo", type="biubiu.events.TaskEvent")]
	
	
	/**
	 * AbstractTask
	 * decide the login follow and broadcast some event
	 * 
	 * @author hbb
	 */
	public class AbstractTask extends EventDispatcher implements ITask
	{
		public function AbstractTask()
		{
		}
		
		/**
		 * @inheritDoc 
		 */
		public final function start():void
		{
			dispatchEvent(new TaskEvent(TaskEvent.START));
			start_();
		}
		
		/**
		 * real start implemention
		 */
		protected function start_():void
		{
			execute();
		}
		
		/**
		 * @inheritDoc 
		 */
		public final function execute():void
		{
			dispatchEvent(new TaskEvent(TaskEvent.EXECUTE));
			execute_();
		}
		
		/**
		 * real execute implemention
		 */
		protected function execute_():void
		{
			complete();
		}
		
		/**
		 * @inheritDoc 
		 */
		public final function complete():void
		{
			dispatchEvent(new TaskEvent(TaskEvent.COMPLETE));
		}
		
		/**
		 * @inheritDoc 
		 */
		public final function undo():void
		{
			dispatchEvent(new TaskEvent(TaskEvent.UNDO));
			undo_();
		}	
		
		/**
		 * real undo implemention 
		 */
		protected function undo_():void
		{
			complete();
		}
		
		/**
		 * optmize dispatch event 
		 * @param type
		 */
		override public function dispatchEvent( e:TaskEvent ):void
		{
			if(hasEventListener(e.type))
			{
				dispatchEvent( e );
			}
		}
	}
}