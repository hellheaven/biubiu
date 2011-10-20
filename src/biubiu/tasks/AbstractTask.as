package biubiu.tasks
{
	import biubiu.events.EventCaster;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name="TaskStart", type="flash.events.Event")]
	
	[Event(name="TaskExecute", type="flash.events.Event")]
	
	[Event(name="TaskComplete", type="flash.events.Event")]
	
	
	/**
	 * AbstractTask
	 * decide the login follow and broadcast some event
	 * 
	 * @author hbb
	 */
	public class AbstractTask implements ITask
	{
		public function AbstractTask()
		{
			throw new Error("You can not instantiate an abstract task.");
		}
		
		/**
		 * @inheritDoc 
		 */
		public final function start():void
		{
			broadcast.dispatchEvent(new Event("TaskStart"));
			start_();
		}
		
		/**
		 * essential start implemention
		 * child class should override this
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
			broadcast.dispatchEvent(new Event("TaskExecute"));
			execute_();
		}
		
		/**
		 * essential execute implemention 
		 * child class should override this
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
			broadcast.dispatchEvent(new Event("TaskComplete"));
		}
		
		/**
		 * @inheritDoc 
		 */
		public function get broadcast():EventDispatcher
		{
			return _broadcast;
		}
		private var _broadcast:EventCaster = new EventCaster();
	}
}