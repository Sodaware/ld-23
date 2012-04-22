package overlays 
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ScreenOverlay extends FlxGroup 
	{
		
		public var onHideFinished:Function;
		public var onShowFinished:Function;
		
		protected var isHiding:Boolean = false;
		protected var isAppearing:Boolean = false;
		
		public function ScreenOverlay() 
		{
			super();
		}
		
		public function hide() : void
		{
			this.isHiding = true;
		}
		
		public function show() : void
		{
			this.isAppearing = true;
		}
		
	}

}