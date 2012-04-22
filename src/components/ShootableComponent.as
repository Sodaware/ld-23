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
		
		
		public function ShootableComponent(maxHealth:int) 
		{
			this._maxHealth = maxHealth;
			this._health = maxHealth;
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
		
	}

}