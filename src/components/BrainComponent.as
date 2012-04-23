package components 
{
	import events.GameEventDispatcher;
	import events.TurnStartEvent;
	import util.actions.MoveEntityForwardAction;
	import util.EntityAction;
	import util.EntityActionFactory;
	import db.ContentDb;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class BrainComponent extends BaseComponent 
	{
		
		public function BrainComponent() 
		{
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_GO_PRESSED, this.Handle_beforeTurnStart, false, 0, true);
		}
		
		private function Handle_beforeTurnStart(e:TurnStartEvent) : void
		{
			// Get move queue
			var movement:MoveableObjectComponent = this.getParent().getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (!movement) return;
			
			// Ok, now to decide what we want to do
			
			// Now to do it
			for (var i:int = 0; i < e.playerQueueSize; i++) {
				
				// See where we can move
				var action:Number = Math.random();
				if (action < 0.2) {
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
				
			}
			
		}
		
	}

}