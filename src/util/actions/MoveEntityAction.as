package util.actions 
{
	import components.ShootableComponent;
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
		
		/**
		 * Check if the entity can move to a new position.
		 * 
		 * @param	entity
		 * @param	xPos
		 * @param	yPos
		 * @return
		 */
		public function canMove(entity:GameObject, xPos:int, yPos:int) : Boolean
		{
			// Check map tiles
			var tileX:int 	= xPos / 16;
			var tileY:int 	= yPos / 16;
			var tileId:int	= entity.getMap().getTile(tileX, tileY);
			
			if (xPos < 0 || xPos > entity.getMap().width) return false;
			if (yPos < 0 || yPos > entity.getMap().height) return false;
			
			
			
			if (tileId >= 4) {
				return false;
			}
			
			// Check for entities
			for each (var obj:GameObject in GameObjectDb.getObjectsWithComponent(ShootableComponent)) {
				
				// Ignore self
				if (obj == this._entity) continue;
				
				if (obj.x == xPos && obj.y == yPos) {
					return false;
				}
			}
			
			return true;
			
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
				this.setFinished(true);
				this._entity.stand();
			}
	
		}
		
		public override function execute() : void
		{
			this._delay = new FlxDelay(1500);
			this._delay.start();
		}
		
	}

	
	
}