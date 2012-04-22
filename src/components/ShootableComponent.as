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
			
			// Make a little flyoff
			var event:DamageEvent = new DamageEvent(this.getParent(), bullet.getStrength());
			GameEventDispatcher.getInstance().dispatchEvent(event);
			
			this._health -= bullet.getStrength();
			if (this._health <= 0) {
				this.getParent().kill();
				FlxG.play(ResourceDb.snd_Explosion1);
			} else {
				FlxG.play(ResourceDb.snd_Hit1);
			}
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