package util 
{
	import db.ContentDb;
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
		
		public function EntityAction(eventType:int, args:Object = null) 
		{
			this._eventType = eventType;
		}
		
		public function attach(obj:GameObject) : void
		{
			this._entity = obj;
		}
		
		public function update() : void
		{
			
		}
		
		public function isFinished() : Boolean
		{
			return this._isFinished;
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