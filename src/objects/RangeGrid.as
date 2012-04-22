package objects 
{

	import db.ResourceDb;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxU;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class RangeGrid extends FlxGroup
	{
		
		private var _spriteGrid:Array;
		
		// This stinks, but is fast enough for now.
		public function RangeGrid(object:GameObject, size:int, color:Number) : void
		{
			//this._spriteGrid = new Array(size, size);
			
			for (var x:int = -size; x <= size; x++) {
				for (var y:int = -size; y <= size; y++) {
					
					var xPos:int = object.x + (x * 16); 
					var yPos:int = object.y + (y * 16);
					var distance:Number = FlxU.getDistance(new FlxPoint(object.x, object.y), new FlxPoint(xPos, yPos));
					
					if (distance <= (size * 16)) {
						var sprite:FlxSprite = new FlxSprite(object.x + (x * 16), object.y + (y * 16), ResourceDb.gfx_RangeOverlay);
					
						sprite.color = color;
						sprite.alpha = 0.5;
						this.add(sprite);
					}
				}
			}
			
		}
		
		/**
		 * Check if an object is in this range.
		 * 
		 * @param	object
		 * @return  True if in range, false if not.
		 */
		public function isObjectInGrid(object:GameObject) : Boolean
		{
			return FlxG.overlap(this, object);
		}
		
	}

}