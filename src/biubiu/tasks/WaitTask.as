package biubiu.tasks
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Wait Task
	 * @author hbb
	 */
	public class WaitTask extends AbstractTask implements ITask
	{
		private var _timer:Timer;
		private var _delay:Number;
		/**
		 * Constructor 
		 * @param delay, default is 0
		 */
		public function WaitTask( delay:Number = 0.0 )
		{
			_delay = delay > 0 ? delay : 0;
		}
		
		override protected function start_():void
		{
			if(_delay == 0)
			{
				this.execute();
			}
			else
			{
				if(!_timer) _timer = new Timer(_delay);
				_timer.delay = _delay;
				_timer.addEventListener(TimerEvent.TIMER, onTimer);
				_timer.stop();
				_timer.reset();
				_timer.start();
			}
		}
		
		protected function onTimer(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER, onTimer);
			_timer = null;
			
			this.execute();
		}
		
		override protected function undo_():void
		{
			start_();
		}
	}
}