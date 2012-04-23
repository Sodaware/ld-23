package components 
{
	import db.ContentDb;
	import db.GameObjectDb;
	import objects.PlayerRobot;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;
	import util.EntityAction;
	import util.EntityActionFactory;
	import events.TurnStartEvent;
	import events.GameEventDispatcher;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class EnemyComponent extends BaseComponent 
	{
		
		public function EnemyComponent() 
		{
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_GO_PRESSED, this.Handle_beforeTurnStart, false, 0, true);
		}
		
		private function Handle_beforeTurnStart(e:TurnStartEvent) : void
		{
			// Get move queue
			var movement:MoveableObjectComponent = this.getParent().getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (!movement) return;
			
			// Ok, now to decide what we want to do
			
			// Get the player
			var player:PlayerRobot = GameObjectDb.find("player") as PlayerRobot;
			
			// Distance
			var distance:Number = FlxU.getDistance(new FlxPoint(player.x, player.y), new FlxPoint(this.getParent().x, this.getParent().y));
			
			for (var i:int = 0; i < e.playerQueueSize; i++) {

				var action:Number = Math.random();
				
				if (Math.floor(distance / 16) < 3) {
					movement.addAction(EntityActionFactory.create(ContentDb.ACTION_SHOOT, { target: player } ));
				} else {
					if (action < 0.1) {
						movement.addAction(EntityActionFactory.createRandomTurn());
					} else if (action < 0.3) {
						var moveForward:EntityAction = EntityActionFactory.create(ContentDb.ACTION_MOVE_FORWARD);
						if (moveForward.canPerform(this.getParent())) {
							movement.addAction(moveForward);
						} else {
							movement.addAction(EntityActionFactory.create(ContentDb.ACTION_DO_NOTHING));
						}
					} else {
						movement.addAction(EntityActionFactory.create(ContentDb.ACTION_DO_NOTHING));
					}
				
				// If far away, move towards
				
				// If in range, shoot!
				
				// TODO: Tihis range should be based on enemy weapon range
				
				}
				
				// Now to do it
			//	movement.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_RIGHT));
			}
			
			
		}
		
	}

}