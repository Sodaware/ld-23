package ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	
	/**
	 * Same as a regular Flixel group, except it can call a function when the
	 * group is clicked.
	 * 
	 * @author Phil Newton
	 */
	public class ClickableGroup extends FlxGroup 
	{
		
		protected var _x:int;
		protected var _y:int;
		protected var _width:int;
		protected var _height:int;
		
		protected var _mouseOver:Boolean;
		
		public var onEnterHandler:Function;
		public var onLeaveHandler:Function;
		public var onClickHandler:Function;
		
		public override function update() : void
		{
			if (FlxG.mouse.getWorldPosition().x >= this.x && FlxG.mouse.getWorldPosition().x <= this.x + this.width) {
				if (FlxG.mouse.getWorldPosition().y >= this.y && FlxG.mouse.getWorldPosition().y <= this.y + this.height) {
					
					if (!this._mouseOver) {
						this._mouseOver = true;
						if (this.onEnterHandler != null) this.onEnterHandler(this);
					}
					
					if (FlxG.mouse.pressed()) {
						// Fire a clicked event
						if (this.onClickHandler != null) this.onClickHandler(this);
					}
					
					return;
				}
			}
			
			if (this._mouseOver) {
				this._mouseOver = false;
				if (this.onLeaveHandler != null) this.onLeaveHandler(this);
			}
		}
		
		protected function setDimensions(xPos:int, yPos:int, width:int, height:int) : void
		{
			this._x = xPos;
			this._y = yPos;
			this._width = width;
			this._height = height;
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