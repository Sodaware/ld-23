package util.actions 
{
	import util.EntityAction;
	import db.*;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MoveEntityAction extends EntityAction 
	{
		
		private var _endX:int;
		private var _endY:int;
		
		public function MoveEntityAction(eventType:int) 
		{
			super(eventType);
		}
		
		
		public override function update()  : void
		{
			super.update();
			
			if (Math.round(this._entity.x) == this._endX) { 
				this._entity.velocity.x = 0;
				this._entity.x = Math.round(this._entity.x);
			}
			
			
			if (Math.round(this._entity.y) == this._endY) { 
				this._entity.velocity.y = 0;
				this._entity.y = Math.round(this._entity.y);
			}
			
			if (this._entity.velocity.x == 0 && this._entity.velocity.y == 0) {
				this._isFinished = true;
			}
		}
		
		public override function execute() : void
		{
			// Yes, this is horrible. Want to move it to a strategy type class.
			switch (this._eventType) 
			{
				case ContentDb.ACTION_MOVE_FORWARD:
					trace("Moving forward!");
					if (this._entity.getDirection() == GameObject.DIR_DOWN) {
						this._entity.play("walk_down");
						
						this._endX = this._entity.x;
						this._endY = this._entity.y + 16;
						
						this._entity.velocity.y = 16;
						
					}
					break;
				default:
			}
		}
	}

}