package ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxDelay;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MessageBox extends FlxGroup
	{
		
		private var _frame:FlxSprite;
		private var _message:FlxText;
		
		
		public function MessageBox(message:String, xPos:int, yPos:int, width:int, height:int, centerX:Boolean = true) 
		{
			
			if (centerX) {
				xPos = (FlxG.camera.width - width) / 2;
			}
			
			this._message = new FlxText(xPos + 4, yPos + 4, width, message);
			this._message.centerOffsets(false);
			
			var frameOuter:FlxSprite = new FlxSprite(xPos, yPos);
			frameOuter.makeGraphic(width, height, 0xFF2E4B98);
			
			var frameInner:FlxSprite = new FlxSprite(xPos + 2, yPos + 2);
			frameInner.makeGraphic(width - 4, height - 4, 0xFF7892D6);
			
			this.add(frameOuter);
			this.add(frameInner);
			this.add(this._message);
		
		}
		
		
		
		
	}

}