package db 
{
	import objects.GameObject;
	
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class GameObjectDb 
	{
		private static var _objects:Array = new Array();
		
		
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