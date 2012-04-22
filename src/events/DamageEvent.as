package events 
{
	import flash.events.Event;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class DamageEvent extends Event 
	{
		
		private var _damage:int;
		private var _entity:GameObject;
		
		public function DamageEvent(entity:GameObject, damage:int) 
		{
			super(GameEventDispatcher.EVENT_DAMAGE);
			this._entity = entity;
			this._damage = damage;
		}
		
		public function getDamage() : int
		{
			return this._damage;
		}
		
		public function getEntity(): GameObject 
		{
			return _entity;
		}
		
		
	}

}