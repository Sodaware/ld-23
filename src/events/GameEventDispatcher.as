package events 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class GameEventDispatcher extends EventDispatcher 
	{
		private static var _instance:GameEventDispatcher = new GameEventDispatcher();
		
		public static const EVENT_DAMAGE:String = "damage";
		
		public function GameEventDispatcher() 
		{
			
		}
		
		public static function getInstance() : GameEventDispatcher
		{
			return GameEventDispatcher._instance;
		}
		
	}

}