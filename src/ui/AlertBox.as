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
	public class AlertBox extends MessageBox
	{
		private var _message:FlxText;
		private var _lifespan:FlxDelay;
		
		public function AlertBox(message:String, xPos:int, yPos:int, width:int, height:int, centerX:Boolean = true) 
		{
		//	super();
			super(message, xPos, yPos, width, height, centerX);
			if (centerX) {
				xPos = (FlxG.camera.width - width) / 2;
			}
			
			this._message = new FlxText(xPos + 4, yPos + 4, width, message);
			this._message.centerOffsets(false);
			
			var frameOuter:FlxSprite = new FlxSprite(xPos, yPos);
			frameOuter.makeGraphic(width, height, 0xFFFF0909);
			
			var frameInner:FlxSprite = new FlxSprite(xPos + 2, yPos + 2);
			frameInner.makeGraphic(width - 4, height - 4, 0xFFFF5151);
			
			this._message.shadow = 0xAA000000;
			
			this.add(frameOuter);
			this.add(frameInner);
			this.add(this._message);
			
			this._lifespan = new FlxDelay(1200);
			this._lifespan.callback = this.onFinish;
			this._lifespan.start();
		}
		
		public function onFinish() : void
		{
			this.active = false;
			this.kill();
		}
		
		
	}

}