package objects 
{
	import components.BaseComponent;
	import db.GameObjectDb;
	import db.ResourceDb;
	import flash.display.InteractiveObject;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxU;
	
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
		private var _walkSound:FlxSound;
		protected var _map:FlxTilemap;
		protected var _mouseOver:Boolean;
		
		
		
		public var onQueueEmpty:Function;
		
		override public function kill():void 
		{
			super.kill();
			GameObjectDb.remove(this);
		}
		
		public function isMouseOver() : Boolean
		{
			return this._mouseOver;
		}
		
		public function setMap(map:FlxTilemap) : void
		{
			this._map = map;
		}
		
		public function getMap() : FlxTilemap
		{
			return this._map;
		}
		
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
		
		public function walk(endX:int, endY:int) : void
		{
			this.velocity.x = endX - this.x;
			this.velocity.y = endY - this.y;
			
			this._walkSound = FlxG.play(ResourceDb.snd_Step, 1, true);
			
			switch (this._direction) 
			{
				case GameObject.DIR_LEFT:
					this.play("walk_left");
					break;

				case GameObject.DIR_RIGHT:
					this.play("walk_right");
					break;

				case GameObject.DIR_UP:
					this.play("walk_up");
					break;

				case GameObject.DIR_DOWN:
					this.play("walk_down");
					break;
					
			}
		}
		
		public function setDirection(dir:int = -1) : void
		{
			this._direction = dir;
			this.stand();
		}
		
		public function stand() : void
		{
			if (this._walkSound) {
				this._walkSound.stop();
			}
			
			switch (this._direction) 
			{
				case GameObject.DIR_LEFT:
					this.play("stand_left");
					break;

				case GameObject.DIR_RIGHT:
					this.play("stand_right");
					break;

				case GameObject.DIR_UP:
					this.play("stand_up");
					break;

				case GameObject.DIR_DOWN:
					this.play("stand_down");
					break;
					
			}
		}
		
		public override function update() : void
		{
			super.update();
			for each (var cmp:BaseComponent in this._components) {
				cmp.update();
			}
			
			// Check if mouse overlaps
			this._mouseOver = false;
			if (FlxG.mouse.getWorldPosition().x >= this.x && FlxG.mouse.getWorldPosition().x <= this.x + this.width) {
				if (FlxG.mouse.getWorldPosition().y >= this.y && FlxG.mouse.getWorldPosition().y <= this.y + this.height) {
					this._mouseOver = true;
				}				
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