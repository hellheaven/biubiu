package biubiu.tasks
{
	import flash.events.EventDispatcher;

	public interface ITask
	{
		/**
		 * start to execute 
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
		 * to broadcast event
		 */
		function get broadcaster():EventDispatcher;
	}
}