package biubiu.tasks
{
	import flash.events.Event;

	/**
	 * FunctionTask
	 * wrap a function to execute 
	 * @author hbb
	 */
	public class FunctionTask extends AbstractTask implements ITask
	{
		private var _fn:Function;
		private var _args:Array;
		private var _undoFn:Function;
		private var _undoArgs:Array;
		
		/**
		 * Constructor 
		 * @param fn
		 * @param args
		 * @param undoFn, default is fn
		 * @param undoArgs, default is args
		 * 
		 */
		public function FunctionTask( fn:Function, args:Array, undoFn:Function = null, undoArgs:Array = null )
		{
			_fn = fn;
			_args = args;
			_undoFn = undoFn || fn;
			_undoArgs = undoArgs || args;
		}
		
		override final protected function execute_():void
		{
			try{
				_fn.apply(null, _args);
			}catch(ex:Error){
				fail();
			}
		}
		
		override final protected function undo_():void
		{
			try{
				_undoFn.apply(null, _undoArgs);
			}catch(ex:Error){
				fail();
			}
		}
	}
}