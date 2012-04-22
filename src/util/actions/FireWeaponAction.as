package util.actions 
{
	import db.ResourceDb;
	import objects.Bullet;
	import objects.GameObject;
	import org.flixel.FlxG;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import util.EntityAction;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class FireWeaponAction extends EntityAction
	{
		private var _delay:FlxDelay;
		
		public function FireWeaponAction(eventType:int, args:Object)
		{
			super(eventType, args);
		}
		
		public override function update() : void
		{
			if (this._delay && this._delay.hasExpired) {
				this.setFinished(true);
			}
		}
		
		public override function execute() : void
		{
			this._delay = new FlxDelay(1500);
			this._delay.start();
			
			
			var bullet:Bullet = new Bullet(this._entity.x + (this._entity.width / 2), this._entity.y + (this._entity.height / 2), ResourceDb.gfx_Bullet);
			bullet.setParent(this._entity);
			bullet.setStrength(5);
			
			// Calculate target position
			var target:GameObject = GameObject(this.getArg("target"));
			if (!target) {
				return;
			}
			
			FlxG.play(ResourceDb.snd_Shoot1);
			
			bullet.velocity.x = -2 * (this._entity.x - target.x);
			bullet.velocity.y = -2 * (this._entity.y - target.y);

			FlxG.state.add(bullet);

			
		}
		
	}

}