package util.actions 
{
	import db.ContentDb;
	import util.EntityAction;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class DoNothingAction extends EntityAction 
	{
		private var _delay:FlxDelay;
		
		public function DoNothingAction() 
		{
			super(ContentDb.ACTION_DO_NOTHING);
		}
		
		override public function update():void 
		{
			
			if (this._delay && this._delay.hasExpired) {
				this.setFinished(true);
			}
		}
		
		override public function execute():void 
		{
			this._delay = new FlxDelay(1500);
			this._delay.start();
		}
		
	}

}