package screens
{
	import org.flixel.*;
	
	/**
	 * Basic title screen.
	 * @author Phil Newton
	 */
	public class TitleScreenState extends FlxState
	{
		
		private var _versionText:FlxText;
		
		/**
		 * Create the title screen.
		 */
		override public function create():void
		{
			
			
			// Version info
			this._versionText				= new FlxText(FlxG.width - 120, FlxG.height - 12, 120, "v" + ApplicationInfo.getVersionNumber());
			this._versionText.shadow		= 0x88000000;
			this._versionText.alignment		= "right";
			
			this.add(this._versionText);
		}
		
		/**
		 * Updates the title screen and checks for input
		 */
		override public function update():void
		{
			super.update(); 
						
			// Check for start
			if(FlxG.keys.SPACE) {
			//	FlxG.state = new MainGameState();
			}
		}
		
	}

}