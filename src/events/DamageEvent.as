package events 
{
	import events.GameObjectEvent;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class DamageEvent extends GameObjectEvent 
	{
		
		private var _damage:int;
		private var _isFatal:Boolean = false
		
		public function DamageEvent(entity:GameObject, damage:int = 0) 
		{
			super(GameEventDispatcher.EVENT_DAMAGE, entity);
			this._damage = damage;
		}
		
		public function setIsFatal(fatal:Boolean) : void
		{
			this._isFatal = fatal;
		}
		
		public function getDamage() : int
		{
			return this._damage;
		}
		
		public function isFatal() : Boolean
		{
			return this._isFatal;
		}
		
		
	}

}