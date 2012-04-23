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

				case ContentDb.ACTION_DO_NOTHING:
					return new DoNothingAction();
					break;
					
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
					
				case ContentDb.ACTION_SCAN:
					return new ScanObjectAction(actionType, args);
					break;
				
				default:
					return null;
					break;
				
			}
			
		}
		
		public static function createRandomTurn() : EntityAction
		{
			var rand:Number = Math.random();
			
			if (rand < 0.50) {
				return EntityActionFactory.create(ContentDb.ACTION_TURN_LEFT);
			} else {
				return EntityActionFactory.create(ContentDb.ACTION_TURN_RIGHT);				
			}
		}
		
	}

}