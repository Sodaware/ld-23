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
		private var _ship:FlxSprite;
		
		private var _titleOverlay:TitleScreenMenuOverlay;
		private var _currentOverlay:ScreenOverlay;
		
		/**
		 * Create the title screen.
		 */
		public function TitleScreenState() : void
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

			this._ship = new FlxSprite(FlxG.width + 10, 64, ResourceDb.gfx_TitleShip);
			this._ship.velocity.x = -4;
			this.add(this._ship);
			
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
		
		public function setOverlay(overlay:Class) : void
		{
			
			if (this._currentOverlay) {
				this._currentOverlay.destroy();
				this.remove(this._currentOverlay);
			}
			
			switch (overlay) {
				case ModeSelectScreenOverlay:
					this._currentOverlay = new ModeSelectScreenOverlay();
					this._currentOverlay.onHideFinished = Handle_onMissionSelectClick;
					this.add(this._currentOverlay);
					break;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			if (this._ship.x < -this._ship.width) {
				this._ship.y += (Math.random() * 6) - 12;
				this._ship.x = FlxG.width + (Math.random() * 12);
			}
		}
		
		public function Handle_onStartClick(args:Object) : void
		{
			this.setOverlay(ModeSelectScreenOverlay);
		}
		
		public function Handle_onMissionSelectClick(args:Object) : void
		{
			this._currentOverlay.destroy();
			this.remove(this._currentOverlay);
			
			switch (args["button"]) {
				
				case "biome_select":
					this._currentOverlay = new BiomeSelectScreenOverlay();
					this._currentOverlay.onHideFinished = Handle_onBiomeSelectClick;
					this.add(this._currentOverlay);
					break;
					
				case "bestiary":
					this._currentOverlay = new BestiaryScreenOverlay();
					this._currentOverlay.onHideFinished = Handle_onBestiarySelectClick;
					this.add(this._currentOverlay);
					break;
			}
			
			
		}
		
		public function Handle_onBestiarySelectClick(args:Object) : void
		{
			this._currentOverlay.destroy();
			this.remove(this._currentOverlay);
			
			if (args["button"] == 'back') {
				this._currentOverlay = new ModeSelectScreenOverlay();
				this._currentOverlay.onHideFinished = Handle_onMissionSelectClick;
				this.add(this._currentOverlay);
				return;
			}
			
			this._currentOverlay = new AnimalInfoScreenOverlay(args["button"]);
			this._currentOverlay.onHideFinished = Handle_onExitAnimalInfoClick;
			this.add(this._currentOverlay);
			
		}
		
		public function Handle_onBiomeSelectClick(args:Object) : void
		{
			if (args["button"] == 'back') {
				this._currentOverlay.destroy();
				this.remove(this._currentOverlay);
				this._currentOverlay = new ModeSelectScreenOverlay();
				this._currentOverlay.onHideFinished = Handle_onMissionSelectClick;
				this.add(this._currentOverlay);
				return;
			}
			
			FlxG.fade(0xFF000000, 1, function() : void {
				FlxG.switchState(new PlayState(args.id));	
			});
		}
		
		public function Handle_onExitAnimalInfoClick(args:Object) : void
		{
			this._currentOverlay.destroy();
			this.remove(this._currentOverlay);
			
			this._currentOverlay = new BestiaryScreenOverlay();
			this._currentOverlay.onHideFinished = Handle_onBestiarySelectClick;
			this.add(this._currentOverlay);
			
		}
		
		override public function destroy():void
		{
			FlxSpecialFX.clear();
			super.destroy();
		}
		
	}

}