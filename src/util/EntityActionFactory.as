package util 
{
	
	import db.ContentDb;
	import util.actions.*;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class EntityActionFactory 
	{
		
		public static function create(actionType:int) : EntityAction
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
					
				default:
					return null;
					break;
				
			}
			
		}
		
	}

}