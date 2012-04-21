package
{
	// Import Flixel library & main game code
	import org.flixel.*; 
	import screens.TitleScreenState;
	import screens.PlayState;

	// Set options for Flash file
	[SWF(width="320", height="304", backgroundColor="#000000")]
 	
	/**
	 * Main game class for Ludum Dare #23
	 */
	public class Ineptia extends FlxGame
	{
		public function Ineptia()
		{
			// 270 for widescreen
			super(160, 152, PlayState, 2);
		}

	}

}