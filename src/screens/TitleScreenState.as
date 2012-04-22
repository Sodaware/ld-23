package screens
{
	import db.ResourceDb;
	import overlays.*;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import org.flixel.plugin.photonstorm.FlxSpecialFX;
	import org.flixel.plugin.photonstorm.FX.StarfieldFX;
	
	
	/**
	 * Basic title screen.
	 * @author Phil Newton
	 */
	public class TitleScreenState extends FlxState
	{
		
		private var _versionText:FlxText;
		private var _background:FlxSprite;
		private var _stars:StarfieldFX;
		
		private var _titleOverlay:TitleScreenMenuOverlay;
		private var _currentOverlay:ScreenOverlay;
		
		/**
		 * Create the title screen.
		 */
		override public function create():void
		{
			if (FlxG.getPlugin(FlxSpecialFX) == null) {
				FlxG.addPlugin(new FlxSpecialFX);
			}
			
			// Moose
			FlxG.mouse.load(ResourceDb.gfx_Cursor, 2);
			
			// Stars
			this._stars = FlxSpecialFX.starfield();
			this._stars.setStarSpeed(-0.1, 0);
			this._background = this._stars.create(0, 0, FlxG.width, FlxG.height, 50, 1, 16);
			this.add(this._background);

			this._currentOverlay = new TitleScreenMenuOverlay();
			this._currentOverlay.onHideFinished = this.Handle_onStartClick;
			this._currentOverlay.show();
			this.add(this._currentOverlay);
				
			// Version info
			this._versionText				= new FlxText(FlxG.width - 120, FlxG.height - 12, 120, "v" + ApplicationInfo.getVersionNumber());
			this._versionText.shadow		= 0x88000000;
			this._versionText.alignment		= "right";
			
			this.add(this._versionText);
			
		}
		
		public function Handle_onStartClick(args:Object) : void
		{
			this._currentOverlay.destroy();
			this.remove(this._currentOverlay);
			
			this._currentOverlay = new ModeSelectScreenOverlay();
			this._currentOverlay.onHideFinished = Handle_onMissionSelectClick;
			this.add(this._currentOverlay);
		}
		
		public function Handle_onMissionSelectClick(args:Object) : void
		{
			this._currentOverlay.destroy();
			this.remove(this._currentOverlay);
			
			this._currentOverlay = new MissionSelectScreenOverlay();
			this.add(this._currentOverlay);
			
			this._currentOverlay.onHideFinished = Handle_onBiomeSelectClick;
			
		}
		
		public function Handle_onBiomeSelectClick(args:Object) : void
		{
			switch (args.id) {
				case "zone_temperate":
					trace("We're going to the TEMPERATE zone");
					FlxG.switchState(new PlayState());
					break;
			}
//			
			
		}
		
		override public function destroy():void
		{
			FlxSpecialFX.clear();
			super.destroy();
		}
		
	}

}