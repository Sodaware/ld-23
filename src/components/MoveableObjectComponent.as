package components 
{
	import util.*;
	
	/**
	 * Component that handles objects that have a movement queue.
	 * @author Phil Newton
	 */
	public class MoveableObjectComponent extends BaseComponent
	{
		protected var _queue:ActionQueue;
		protected var _currentAction:EntityAction;
		
		public function MoveableObjectComponent() 
		{
			this._queue = new ActionQueue();
		}
		
		public override function afterAttach() : void
		{
			this._queue.attach(this.getParent());
		}
		
		public function addAction(action:EntityAction) : void
		{
			this._queue.push(action);
		}
		
		public override function update() : void
		{
			if (this._currentAction != null) {
				
				this._currentAction.update();
				
				if (this._currentAction.isFinished()) {
					this.executeQueue();
				}
			}
			
			
		}
		
		public function executeQueue() : void
		{
			if (this._queue.isEmpty()) {
				this._currentAction = null;
				return;
			}
			
			this._currentAction = this._queue.pop();
			this._currentAction.attach(this.getParent());
			this._currentAction.execute();
		}
		
		
		
	}

}