package util.actions 
{
	import util.actions.MoveEntityAction;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class TurnEntityLeftAction extends MoveEntityAction 
	{
		
		public override function execute() : void
		{
			
			super.execute();
			
			switch (this._entity.getDirection()) {
				
				case GameObject.DIR_UP:
					this._entity.setDirection(GameObject.DIR_LEFT);
					break;
				
				case GameObject.DIR_RIGHT:
					this._entity.setDirection(GameObject.DIR_UP);
					break;
				
				case GameObject.DIR_DOWN:
					this._entity.setDirection(GameObject.DIR_RIGHT);
					break;
				
				case GameObject.DIR_LEFT:
					this._entity.setDirection(GameObject.DIR_DOWN);
					break;
				
			}
			
			this._entity.walk(this._entity.x, this._entity.y);
			
		}
		
		public override function evaluate(entity:GameObject) : void
		{
			
			switch (entity.getDirection()) {
				
				case GameObject.DIR_UP:
					entity.setDirection(GameObject.DIR_LEFT);
					break;
				
				case GameObject.DIR_RIGHT:
					entity.setDirection(GameObject.DIR_UP);
					break;
				
				case GameObject.DIR_DOWN:
					entity.setDirection(GameObject.DIR_RIGHT);
					break;

				case GameObject.DIR_LEFT:
					entity.setDirection(GameObject.DIR_DOWN);
					break;
				
			}
		
		}
		
	}

}