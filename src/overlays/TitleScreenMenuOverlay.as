package overlays 
{
	import db.ContentDb;
	import org.flixel.FlxButton;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import db.ResourceDb;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	/**
	 * Main title menu
	 */
	public class TitleScreenMenuOverlay extends ScreenOverlay 
	{
		private var _title:FlxSprite;		
		private var _startButton:FlxButtonPlus;
		
		public function TitleScreenMenuOverlay() 
		{
			super();
			
			// Title
			this._title = new FlxSprite(0, 16, ResourceDb.gfx_Title);
			this._title.alpha = 0;
			this.add(this._title);
			
			this._startButton = new FlxButtonPlus(0, 100, this.Handle_onStartClick, null, "Start");
			this._startButton.updateInactiveButtonColors([0xFFB4C2E7, 0xFF7993D5]);
			this._startButton.updateActiveButtonColors([0xFFC5D3F8, 0xFF8AA4E6]);
			this._startButton.screenCenter();			
			this.add(this._startButton);
		}
		
		override public function update():void 
		{
			super.update();
			
			// TODO: Move these to generic fade in / fade out functions
			if (this.isHiding) {
				this._title.alpha -= ContentDb.TRANSITION_SPEED;
				if (this._title.alpha <= 0) {
					this.isHiding = false;
					if (this.onHideFinished != null) this.onHideFinished(null);
				}
			}
			
			if (this.isAppearing) {
				this._title.alpha += ContentDb.TRANSITION_SPEED;
				if (this._title.alpha >= 1) {
					this.isAppearing= false;
					if (this.onShowFinished != null) this.onShowFinished(null);
				}
			}
		}
		
		public function Handle_onStartClick() : void
		{
			this.hide();
		}
		
	}

}