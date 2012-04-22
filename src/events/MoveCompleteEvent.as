package events 
{
	import flash.events.Event;
	import objects.GameObject;
	import util.EntityAction;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MoveCompleteEvent extends Event 
	{
		
		private var _entity:GameObject;
		private var _action:EntityAction;
		
		public function MoveCompleteEvent(entity:GameObject, action:EntityAction) 
		{
			super(GameEventDispatcher.EVENT_MOVE_COMPLETED);
			this._entity = entity;
			this._action = action;
		}
		
		public function getAction() : EntityAction
		{
			return this._action;
		}
		
		public function getEntity(): GameObject 
		{
			return _entity;
		}
		
	}

}