package util 
{
	import db.ContentDb;
	import objects.GameObject;
	import org.flixel.FlxParticle;
	import org.flixel.FlxPath;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class EntityAction 
	{
		protected var _eventType:int;
		protected var _entity:GameObject;
		protected var _isFinished:Boolean;
		
		public function EntityAction(eventType:int) 
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
		
	}

}