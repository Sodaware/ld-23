package util 
{
	import org.flixel.FlxSprite;
	
	/**
	 * Holds a bunch of actions that can be carried out by a player or 
	 * other entity.
	 * 
	 * @author Phil Newton
	 */
	public class ActionQueue 
	{
		private var _actions:Array;
		private var _object:FlxSprite;
		
		public function ActionQueue() 
		{
			this._actions = new Array();
		}
		
		public function attach(obj:FlxSprite) : void
		{
			this._object = obj;
		}
		
		public function isEmpty() : Boolean
		{
			return (this._actions.length == 0);
		}
		
		public function push(action:EntityAction) : int
		{
			this._actions.push(action)
			return this._actions.length;
		}
		
		public function pop() : EntityAction
		{
			return this._actions.shift();
		}
		
		public function execute() : void
		{
			while (this._actions.length) {
				var action:EntityAction = this.pop();
				action.execute();
			}
		}
		
	}

}