package util.actions 
{
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import util.EntityAction;
	import db.*;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MoveEntityAction extends EntityAction 
	{
		private var _delay:FlxDelay;
		protected var _endX:int;
		protected var _endY:int;
		
		protected function _setEndPosition(xPos:int, yPos:int) : void
		{
			this._endX = xPos;
			this._endY = yPos;
		}
		
		protected function _updateEntityAnim() : void
		{
			this._entity.walk(this._endX, this._endY);
		}
		
		public function MoveEntityAction(eventType:int = 0) 
		{
			super(eventType);
		}
		
		
		public override function update()  : void
		{
			super.update();
			
			if (Math.round(this._entity.x) == this._endX) {
				// TODO: Call "entity.stop"
				this._entity.velocity.x = 0;
				this._entity.x = Math.round(this._entity.x);
			}
			
			
			if (Math.round(this._entity.y) == this._endY) { 
				this._entity.velocity.y = 0;
				this._entity.y = Math.round(this._entity.y);
			}

			if (this._delay && this._delay.hasExpired) {
				this._isFinished = true;
				this._entity.stand();
			}
	
		}
		
		public override function execute() : void
		{
			this._delay = new FlxDelay(1200);
			this._delay.start();
		}
		
	}

	
	
}