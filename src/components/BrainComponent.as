package components 
{
	import events.GameEventDispatcher;
	import events.TurnStartEvent;
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
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_GO_PRESSED, this.Handle_beforeTurnStart);
		}
		
		private function Handle_beforeTurnStart(e:TurnStartEvent) : void
		{
			// Get move queue
			var movement:MoveableObjectComponent = this.getParent().getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (!movement) return;
			
			// Ok, now to decide what we want to do
			
			// Now to do it
			for (var i:int = 0; i < e.playerQueueSize; i++) {
				movement.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_RIGHT));
			}
			
		}
		
	}

}