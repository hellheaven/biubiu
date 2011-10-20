package biubiu.tasks
{
	import flash.events.IEventDispatcher;

	public interface ITask extends IEventDispatcher
	{
		/**
		 * start to execute task
		 */
		function start():void;
		/**
		 * execute task 
		 */
		function execute():void;
		/**
		 * complete execution 
		 */
		function complete():void;
		/**
		 * undo task 
		 */
		function undo():void;
		/**
		 * fail task 
		 */		
		function fail():void;
	}
}