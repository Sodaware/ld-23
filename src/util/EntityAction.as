package util 
{
	import components.MoveableObjectComponent;
	import db.ContentDb;
	import events.GameEventDispatcher;
	import events.MoveCompleteEvent;
	import objects.GameObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPath;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * An action that can be carried out by an entity.
	 * 
	 * @author Phil Newton
	 */
	public class EntityAction 
	{
		protected var _eventType:int;
		protected var _entity:GameObject;
		protected var _isFinished:Boolean;
		protected var _args:Object;
		
		public function EntityAction(eventType:int, args:Object = null) 
		{
			this._eventType = eventType;
			this._args = args;
		}
		
		public function getArg(key:String) : Object
		{
			return this._args[key];
		}
		
		public function attach(obj:GameObject) : void
		{
			this._entity = obj;
		}
		
		public function update() : void
		{
			
		}
		
		protected function setFinished(finished:Boolean) : void
		{
			this._isFinished = finished;
			
			if (finished) {
				var event:MoveCompleteEvent = new MoveCompleteEvent(this._entity, this);
				GameEventDispatcher.getInstance().dispatchEvent(event);
			}
		}
		public function isFinished() : Boolean
		{
			return this._isFinished;
		}
		
		
		// ----------------------------------------------------------------------
		// -- Action Querying / Execution
		// ----------------------------------------------------------------------
		
		/**
		 * Check if the sprite can add this action to its queue. Used to check for
		 * collisions.
		 * 
		 * @param	sprite
		 * @return  True if can do, false if not.
		 */
		public function canPerform(sprite:GameObject) : Boolean
		{
			return true;
		}

		public function execute() : void
		{
			
		}
		
		/**
		 * Moves a sprite without animating it.
		 * @param	sprite
		 */
		public function evaluate(sprite:GameObject) : void
		{
			
		}
		
	}

}