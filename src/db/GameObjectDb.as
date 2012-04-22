package db 
{
	import objects.GameObject;
	import org.flixel.FlxGroup;
	
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class GameObjectDb 
	{
		private static var _objects:Array = new Array();
		private static var _entities:FlxGroup = new FlxGroup();
		
		public static function getGroup() : FlxGroup
		{
			return GameObjectDb._entities;
		}
		
		public static function find(name:String) : GameObject
		{
			for each (var obj:GameObject in GameObjectDb._objects) {
				if (obj.tag == name) {
					return obj;
				}
			}
			
			return null;
		}
		
		public static function add(obj:GameObject) : void
		{
			GameObjectDb._objects.push(obj);
			GameObjectDb._entities.add(obj);
		}
		
		public static function remove(obj:GameObject) : void
		{
			GameObjectDb._objects.splice(GameObjectDb._objects.indexOf(obj), 1);
		}
		
		public static function getObjectsWithComponent(component:Class) : Array
		{
			var objectList:Array = new Array();
			
			for each (var obj:GameObject in GameObjectDb._objects) {
				if (obj.hasComponent(component)) {
					objectList.push(obj);
				}
			}
			
			return objectList;
		}
		
	}

}