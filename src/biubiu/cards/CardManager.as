package biubiu.cards
{
	/**
	 * CardManager
	 * push and pop card 
	 * @author hbb
	 * 
	 */
	public class CardManager
	{
		private var _map:Object = {};
		private var _stack:Array = [];
		public function CardManager()
		{
		}
		
		/**
		 * register a card 
		 * @param id
		 * @param card
		 */
		public function registerCard( id:String, card:ICard ):void
		{
			_map[id] = card;
		}
		
		/**
		 * push the specifed card to show 
		 * @param id
		 * 
		 */
		public function push( id:String ):void
		{
			var card:ICard = get(id);
			if(!card) return;
			
			_stack.push( id );
		}
		
		/**
		 * pop the top card
		 * @param toId
		 * 
		 */
		public function pop( toId:String = "" ):void
		{
			_stack.pop();
		}
		
		public function get( id:String ):ICard
		{
			return _map[id];
		}
	}
}