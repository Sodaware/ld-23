package util.actions 
{
	import org.flixel.plugin.photonstorm.FlxDelay;
	import util.EntityAction;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class FireWeaponAction extends EntityAction
	{
		
		private var _delay:FlxDelay;
		
		public function FireWeaponAction(eventType:int, args:Object = null) 
		{
			super(eventType, args);
			trace(args["weapon"]);
		}
	
		public override function update() : void
		{
			if (this._delay && this._delay.hasExpired) {
				this._isFinished = true;
			}
		}
		
		public override function execute() : void
		{
			this._delay = new FlxDelay(1500);
			this._delay.start();
		}
		
	}

}