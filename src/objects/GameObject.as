package objects 
{
	import components.BaseComponent;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class GameObject extends FlxSprite
	{
		// Directions
		public static const DIR_UP:int = 0;
		public static const DIR_RIGHT:int = 1;
		public static const DIR_LEFT:int = 2;
		public static const DIR_DOWN:int = 3;

		private var _direction:int = GameObject.DIR_DOWN;
		
		private var _components:Array;
		
		public function getDirection() : int
		{
			return this._direction;
		}
		
		public function hasComponent(componentType:Class) : Boolean
		{
			return (this.findComponent(componentType) != -1);
		}
		
		public function findComponent(componentType:Class) : int
		{
			var pos:int = 0;
			for each (var cmp:BaseComponent in this._components) {
				
				if (Object(cmp).constructor == componentType) {
					return pos;
				}
				pos++;
				
			}
			
			return -1;
		}
		
		public override function update() : void
		{
			super.update();
			for each (var cmp:BaseComponent in this._components) {
				cmp.update();
			}
		}
		
		public function getComponent(componentType:Class) : BaseComponent
		{
			var pos:int = this.findComponent(componentType);
			return (pos != -1) ? this._components[pos] : null;
		}
		
		public function GameObject(x:int = 0, y:int = 0, gfx:Class = null) 
		{
			super(x, y, gfx);
			this._components = new Array();
		}
		
		public function addComponent(cmp:BaseComponent) : void
		{
			this._components.push(cmp);
			cmp.attach(this);
		}
		
	}

}