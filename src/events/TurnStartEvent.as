package events 
{
	import components.MoveableObjectComponent;
	import flash.events.Event;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class TurnStartEvent extends Event 
	{
		
		private var _playerQueueSize:int;
		
		public function TurnStartEvent(player:GameObject) 
		{
			super(GameEventDispatcher.EVENT_GO_PRESSED);
			
			var queue:MoveableObjectComponent = player.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			this._playerQueueSize = queue.getSize();
		}
		
		public function get playerQueueSize():int 
		{
			return _playerQueueSize;
		}
		
	}

}