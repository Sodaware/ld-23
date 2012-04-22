package events 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	/**
	 * Global event handler. Yeah, I know it's not a real singleton.
	 * 
	 * @author Phil Newton
	 */
	public class GameEventDispatcher extends EventDispatcher 
	{
		private static var _instance:GameEventDispatcher = new GameEventDispatcher();
		
		public static const EVENT_DAMAGE:String			= "damage";
		public static const EVENT_MOVE_COMPLETED:String = "move_completed";
		public static const EVENT_GO_PRESSED:String		= "go_pressed";
		public static const EVENT_ENTITY_CLICKED:String	= "entity_clicked";
		
		public function GameEventDispatcher() 
		{
			
		}
		
		public static function getInstance() : GameEventDispatcher
		{
			return GameEventDispatcher._instance;
		}
		
	}

}