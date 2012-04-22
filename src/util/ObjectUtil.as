package util 
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ObjectUtil 
	{

		public static function lock(... args) : void
		{
			for each (var e:FlxSprite in args) {
				e.scrollFactor.x = 0;
				e.scrollFactor.y = 0;
			}
		}
	}

}