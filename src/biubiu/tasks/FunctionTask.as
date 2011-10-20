package biubiu.tasks
{
	/**
	 * FunctionTask
	 * wrap a function to execute 
	 * @author hbb
	 */
	public class FunctionTask extends AbstractTask implements ITask
	{
		private var _fn:Function;
		private var _args:Array;
		
		public function FunctionTask( fn:Function, ...args )
		{
			_fn = fn;
			_args = args;
		}
		
		override final protected function execute_():void
		{
			_fn.apply(null,_args);
		}
	}
}