package components 
{
	import db.ResourceDb;
	import events.DamageEvent;
	import flash.events.Event;
	import events.GameEventDispatcher;
	import objects.Bullet;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ShootableComponent extends BaseComponent 
	{
		private var _health:int;
		private var _maxHealth:int;
		private var _name:String;
		
		public function setHealth(health:int) : void
		{
			this._health = health;
		}

		public function setMaxHealth(health:int) : void
		{
			this._maxHealth = health;
		}

		public function ShootableComponent(maxHealth:int) 
		{
			this._maxHealth = maxHealth;
			this._health = maxHealth;
		}
		
		public function setName(name:String) : void
		{
			this._name = name;
		}
		
		public function getName() : String
		{
			return this._name;
		}
		
		public function hitBy(bullet:Bullet) : void
		{
			
			// Calculate damage
			var damage:int = bullet.getStrength();
			
			// Create event for notify of damage
			var event:DamageEvent = new DamageEvent(this.getParent(), bullet.getStrength());
			
			// Update entity health
			this._health -= damage;
			
			// If entity has no health, kill it
			if (this._health <= 0) {
				
				this.getParent().kill();
				event.setIsFatal(true);
				
				// Effects (can move this)
				FlxG.play(ResourceDb.snd_Explosion1);
				
			} else {
				
				FlxG.play(ResourceDb.snd_Hit1);
				
			}
			
			// Fire the event
			GameEventDispatcher.getInstance().dispatchEvent(event);
		}
		
		public function get health():int 
		{
			return _health;
		}
		
		public function get maxHealth():int 
		{
			return _maxHealth;
		}
		
	}

}