package biubiu.tasks
{
	import flash.events.Event;
	
	public class TaskEvent extends Event
	{
		public static const START:String = "TaskStart";
		public static const EXECUTE:String = "TaskExecute";
		public static const COMPLETE:String = "TaskComplete";
		public static const FAILED:String = "TaskFailed";
		public static const UNDO:String = "TaskUndo";
		
		public function TaskEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}