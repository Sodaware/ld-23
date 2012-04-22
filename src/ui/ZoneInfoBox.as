package ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ZoneInfoBox extends FlxGroup 
	{
		
		private var _info:Object;
		
		private var _name:FlxText;
		private var _icon:FlxSprite;
		
		private var _x:int;
		private var _y:int;
		private var _width:int;
		private var _height:int;
		
		public var onClickHandler:Function;
		
		public function ZoneInfoBox(xPos:int, yPos:int, info:Object) 
		{
			this._info = info;
			
			this._x = xPos;
			this._y = yPos;
			
			this._width = FlxG.width - 8;
			this._height = 40;
			
			this._icon = new FlxSprite(xPos + 0, yPos + 4 , info["icon"]);
			this._name = new FlxText(xPos + 36, yPos + 4, 64, info["name"]);
			
			this.add(this._name);
			this.add(this._icon);
			
			if (info["on_click"]) {
				this.onClickHandler = info["on_click"];
			}
		}
		
		public override function update() : void
		{
			if (FlxG.mouse.getWorldPosition().x >= this.x && FlxG.mouse.getWorldPosition().x <= this.x + this.width) {
				if (FlxG.mouse.getWorldPosition().y >= this.y && FlxG.mouse.getWorldPosition().y <= this.y + this.height) {
					
					if (FlxG.mouse.pressed()) {
						// Fire a clicked event
						if (this.onClickHandler != null) this.onClickHandler(this);
					}
				}
			}
		}
		
		public function getInfo() : Object
		{
			return this._info;
		}
		
		public function get x():int 
		{
			return _x;
		}
		
		public function get y():int 
		{
			return _y;
		}
		
		public function get width():int 
		{
			return _width;
		}
		
		public function get height():int 
		{
			return _height;
		}
		
	}

}