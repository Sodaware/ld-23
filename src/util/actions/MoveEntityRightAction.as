package util.actions 
{
	
	import objects.GameObject;

	
	/**
	 * Moves an entity one square to the right.
	 */
	public class MoveEntityRightAction extends MoveEntityAction 
	{
		
		public override function execute() : void
		{
			super.execute();
			
			switch (this._entity.getDirection()) {
				
				case GameObject.DIR_DOWN:
					this._setEndPosition(this._entity.x - 16, this._entity.y);
					break;
					
				case GameObject.DIR_LEFT:
					this._setEndPosition(this._entity.x, this._entity.y - 16);
					break;
					
				case GameObject.DIR_UP:
					this._setEndPosition(this._entity.x + 16, this._entity.y);
					break;
					
				case GameObject.DIR_RIGHT:
					this._setEndPosition(this._entity.x, this._entity.y + 16);
					break;
				
			}
			
			this._updateEntityAnim();
		}
			
		public override function evaluate(entity:GameObject) : void
		{
			
			switch (entity.getDirection()) { 
				
				case GameObject.DIR_DOWN:
					entity.x -= 16;
					break;
					
				case GameObject.DIR_LEFT:
					entity.y -= 16;
					break;
					
				case GameObject.DIR_UP:
					entity.x += 16;
					break;
					
				case GameObject.DIR_RIGHT:
					entity.y += 16;
					break;
					
			}
			
		}
		
		/**
		 * Check if an entity can move right.
		 * 
		 * @param	entity
		 * @return
		 */
		public override function canPerform(entity:GameObject) : Boolean
		{
			
			switch (entity.getDirection()) { 
				
				case GameObject.DIR_DOWN:
					return (this.canMove(entity, entity.x - 16, entity.y));
					break;
					
				case GameObject.DIR_LEFT:
					return (this.canMove(entity, entity.x, entity.y - 16));
					break;
					
				case GameObject.DIR_UP:
					return (this.canMove(entity, entity.x + 16, entity.y));
					break;
					
				case GameObject.DIR_RIGHT:
					return (this.canMove(entity, entity.x, entity.y + 16));
					break;
					
			}
			
			return false;
			
		}

		
	}

}