package overlays 
{
	import db.ContentDb;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ModeSelectScreenOverlay extends ScreenOverlay 
	{
		
		private var _title:FlxText;
		private var _missionSelectButton:FlxButtonPlus;
		private var _shopSelectButton:FlxButtonPlus;
		private var _bestiarySelectButton:FlxButtonPlus;
		private var _databankSelectButton:FlxButtonPlus;
		
		public function ModeSelectScreenOverlay() 
		{
			this._title = new FlxText(0, 10, FlxG.width, "Select Mode");
			this._title.alignment = "center";
			this._title.size = 16;
			this.add(this._title);
			
			this._missionSelectButton = new FlxButtonPlus(0, 38, Handle_onMissionSelectClick, null, "Mission Select");
			this._missionSelectButton.screenCenter();
			
			this.add(this._missionSelectButton);
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
		
		public function Handle_onMissionSelectClick() : void
		{
			this.hide();
		}
		
	}

}