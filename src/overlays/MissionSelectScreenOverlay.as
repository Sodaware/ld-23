package overlays 
{
	import db.ResourceDb;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import ui.ZoneInfoBox;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MissionSelectScreenOverlay extends ScreenOverlay 
	{
		
		private var _title:FlxText;
		
		
		
		public function MissionSelectScreenOverlay() 
		{
			this._title = new FlxText(0, 10, FlxG.width, "Biome Select");
			this._title.alignment = "center";
			this._title.size = 16;
			this.add(this._title);
			
						
			// Add zone info
			this.add(new ZoneInfoBox(4, 32, {
				id:   "zone_temperate",
				name: "Temperate",
				icon: ResourceDb.gfx_ZoneIconTemperate,
				on_click: this.Handle_onZoneClick
			}));
			
		}
		
		public function Handle_onZoneClick(zone:ZoneInfoBox) : void
		{
			this.hide();
			this.onHideFinished(zone.getInfo());
		}
		
	
		
	}

}