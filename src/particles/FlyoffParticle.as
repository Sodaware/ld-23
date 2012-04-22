package particles 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	
	/**
	 * Stupid text flyoff
	 * @author Phil Newton
	 */
	public class FlyoffParticle extends FlxGroup 
	{

		private var _text:FlxText;
		private var _dieAtY:int;
		
		public function FlyoffParticle(text:String, xPos:int, yPos:int) 
		{
			super(0);
			this._text = new FlxText(xPos, yPos, 16, text);
			this._text.alignment = "center";
			
			
			this.add(this._text);
			this._text.velocity.y = -32;
			this._text.drag.y = 32;
			this._dieAtY = this._text.y - 16;
		}
		
		override public function update():void 
		{
			super.update();
			if (this._text.y <= this._dieAtY) {
				this.kill();
			}
		}
		
	}

}