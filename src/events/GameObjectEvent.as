package events 
{
	import flash.events.Event;
	import objects.GameObject;
	
	/**
	 * Event on an entity
	 */
	public class GameObjectEvent extends Event 
	{
		private var _object:GameObject;
		
		public function GameObjectEvent(eventType:String, e:GameObject) 
		{
			super(eventType);
			this._object = e;
		}
		
		public function getEntity(): GameObject 
		{
			return _object;
		}
		
	}

}