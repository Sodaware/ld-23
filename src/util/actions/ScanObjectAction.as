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
	public class ScanObjectAction extends EntityAction
	{
		private var _delay:FlxDelay;
		
		public function ScanObjectAction(eventType:int, args:Object)
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
			
			// Calculate target position
			var target:GameObject = GameObject(this.getArg("target"));
			if (!target) {
				return;
			}
			
			FlxG.play(ResourceDb.snd_Shoot1);
			
		}
		
	}

}