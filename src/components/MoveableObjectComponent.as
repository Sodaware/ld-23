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
		protected var _maxSize:int = -1;
		
		public function MoveableObjectComponent() 
		{
			this._queue = new ActionQueue();
		}
		
		public function getActions() : ActionQueue
		{
			return this._queue;
		}
		
		public override function afterAttach() : void
		{
			this._queue.attach(this.getParent());
		}
		
		public function addAction(action:EntityAction) : void
		{
			this._queue.push(action);
		}
		
		public function getSize() : int
		{
			return this._queue.getSize();
		}
		
		public function setMaxSize(size:int) : void
		{
			this._maxSize = size;
		}
		
		public function isFull() : Boolean
		{
			return this._queue.getSize() == this._maxSize;
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
		
		public function executeQueue(onFinish:Function = null) : void
		{
			if (this._queue.isEmpty()) {
				this._currentAction = null;
				return;
			}
			
			trace (this._queue.getSize().toString() + " item(s) left");
			trace("Doing something");
			
			this._currentAction = this._queue.pop();
			this._currentAction.attach(this.getParent());
			this._currentAction.execute();
		}
		
		
		
	}

}