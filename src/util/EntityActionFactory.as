package util 
{
	
	import db.ContentDb;
	import util.actions.*;
	
	/**
	 * Creates movement actions that can be added to an entity's movement
	 * queue.
	 */
	public class EntityActionFactory 
	{
		
		public static function create(actionType:int, args:Object = null) : EntityAction
		{
			switch (actionType) {
				
				case ContentDb.ACTION_MOVE_FORWARD:
					return new MoveEntityForwardAction();
					break;
					
				case ContentDb.ACTION_TURN_LEFT:
					return new TurnEntityLeftAction();
					break;
					
				case ContentDb.ACTION_TURN_RIGHT:
					return new TurnEntityRightAction();
					break;

				case ContentDb.ACTION_MOVE_LEFT:
					return new MoveEntityLeftAction();
					break;

				case ContentDb.ACTION_MOVE_RIGHT:
					return new MoveEntityRightAction();
					break;
					
				case ContentDb.ACTION_SHOOT:
					return new FireWeaponAction(actionType, args);
					break;
				
				default:
					return null;
					break;
				
			}
			
		}
		
	}

}