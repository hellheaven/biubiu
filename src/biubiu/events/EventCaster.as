package biubiu.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	/**
	 * Event Caster
	 * this extension of EventDispatcher
	 * add some features such as removeAllListeners, removeListeners,etc.. 
	 * @author hbb
	 * 
	 */
	public class EventCaster extends EventDispatcher
	{
		protected var _events:Object;
		
		/**
		 * @inheritDoc 
		 */
		public function EventCaster(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		/**
		 * remove all listeners 
		 */
		public function removeAllListeners():void
		{
			var type:String;
			
			for(type in _events)
			{
				removeListeners( type );
			}
			_events = null;
		}
		
		/**
		 * remove listeners which specified event type
		 * @param type, event type
		 */
		public function removeListeners(type:String):void
		{
			var listener:*, useCapture:*;
			
			for(listener in _events[type])
			{
				for(useCapture in _events[type][listener])
				{
					super.removeEventListener(type, listener, useCapture);
					delete _events[type][listener][useCapture];
				}
				delete _events[type][listener];
			}
			delete _events[type];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			if(!_events) _events = {};
			if(!_events[type]) _events[type] = new Dictionary(true);
			if(!_events[type][listener]) _events[type][listener] = new Dictionary(true);
			_events[type][listener][useCapture] = true;
			
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			if(!_events) return;
			if(!_events[type]) return;
			if(!_events[type][listener]) return;
			if(!_events[type][listener][useCapture]) return;
			
			super.removeEventListener(type, listener, useCapture);
			
			delete _events[type][listener][useCapture];
			if(isEmpty(_events[type][listener])) delete _events[type][listener];
			if(isEmpty(_events[type])) delete _events[type];
		}
		
		/**
		 * @inheritDoc 
		 */
		override public function dispatchEvent(event:Event):Boolean
		{
			if( super.hasEventListener( event.type ) )
			{
				super.dispatchEvent(event);
			}
		}
		
		private function isEmpty( ob:Object ):Boolean
		{
			for(var i:* in ob) return false;
			return true;
		}
	}
}
