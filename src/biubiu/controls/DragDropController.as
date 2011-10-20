package biubiu.controls
{
	import biubiu.events.EventCaster;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	[Event(name="Drag", type="flash.events.Event")]
	
	[Event(name="Drop", type="flash.events.Event")]

	/**
	 * DragDropController
	 * 
	 * @author hbb
	 * 
	 */
	public class DragDropController
	{
		private var _map:Dictionary = new Dictionary();
		private var _cont:DisplayObjectContainer;
		private var _oldX:Number;
		private var _oldY:Number;
		private var _curr:DragDropItem;
		
		private var _broadcaster:EventCaster = new EventCaster();
		public function get broadcaster():EventCaster
		{
			return _broadcaster;
		}
		
		/**
		 * the current target of dragdrop 
		 * @return 
		 */
		public function get curr():DisplayObject
		{
			return _curr.target;
		}
		
		/**
		 * destroy the controller 
		 */
		public function destroy():void
		{
			broadcast.removeAllListeners();
			
			for(var i:* in _map) removeItem(i);
			_map = null;
			_curr = null;
		}
		
		/**
		 * add target to dragdrop 
		 * @param ob
		 * @param dropBack, put the target back to the start position when it is droped, default is false
		 * @param dragTop, top the target in target's container when dragging, default is true
		 * 
		 */
		public function addItem( ob:InteractiveObject, dropBack:Boolean = false, dragTop:Boolean = true ):void
		{
			removeItem( ob );
			var item:DragDropItem = new DragDropItem( ob, dropBack, dragTop );
			_map[ ob ] = item;
			ob.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		/**
		 * remove the specified object 
		 * @param ob
		 */
		public function removeItem( ob:InteractiveObject ):void
		{
			if(!_map[ob]) return;
			ob.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			delete _map[ob];
		}
		
		
		protected function onMouseDown(e:MouseEvent):void
		{
			var item:DragDropItem = _map[ e.currentTarget ];
			if(!item) return;
			
			_curr = item;
			
			item.target.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			item.target.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			_oldX = e.stageX;
			_oldY = e.stageY;
			
			if(item.top) item.target.parent.addChild( item.target );
			
			broadcaster.dispatchEvent( new Event("Drag") );
		}
		protected function onMouseUp(e:MouseEvent):void
		{
			var item:DragDropItem = _curr;
			if(!item) return;
			
			item.target.stage.removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			item.target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			if(item.back)
			{
				item.target.x = item.startX;
				item.target.y = item.startY;
			}
			
			broadcaster.dispatchEvent( new Event("Drop") );
		}
		protected function onMouseMove(e:MouseEvent):void
		{
			var vx:Number = e.stageX - _oldX;
			var vy:Number = e.stageY - _oldY;
			_oldX = e.stageX;
			_oldY = e.stageY;
			
			_curr.target.x += vx;
			_curr.target.y += vy;
		}
	}
}
import flash.display.InteractiveObject;

class DragDropItem
{
	public var target:InteractiveObject;
	public var back:Boolean;
	public var top:Boolean;
	
	public var startX:Number;
	public var startY:Number;
	
	public function DragDropItem( target:InteractiveObject, back:Boolean, top:Boolean )
	{
		this.target = target;
		this.back = back;
		this.top = top;
		this.startX = target.x;
		this.startY = target.y;
	}
}