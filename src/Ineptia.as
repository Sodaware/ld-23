package
{
	// Import Flixel library & main game code
	import org.flixel.*; 
	import screens.TitleScreenState;

	// Set options for Flash file
	[SWF(width="300", height="250", backgroundColor="#000000")]
 	
	/**
	 * Main game class for RedditGameJam #4 game
	 */
	public class Ineptia extends FlxGame
	{
		public function Ineptia()
		{
			super(150, 125, TitleScreenState, 2);
		}

	}

}