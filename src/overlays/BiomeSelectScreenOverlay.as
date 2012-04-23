package overlays 
{
	import db.ResourceDb;
	import db.ContentDb;
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
	public class BiomeSelectScreenOverlay extends ModalScreenOverlay 
	{
		
			
		
		public function BiomeSelectScreenOverlay() 
		{
			this._title = new FlxText(0, 2, FlxG.width, "Biome Select");
			this._title.alignment = "center";
			this._title.size = 16;
			this.add(this._title);
			
			// Add zone info
			this.add(new ZoneInfoBox(4, 24, {
				id:   "zone_temperate",
				name: "Temperate",
				icon: ResourceDb.gfx_ZoneIconTemperate,
				on_click: this.Handle_onZoneClick
			}));

			this.add(new ZoneInfoBox(4, 60, {
				id:   "zone_desert",
				name: "Desert",
				icon: ResourceDb.gfx_ZoneIconDesert,
				on_click: this.Handle_onZoneClick
			}));
			
			this.add(new ZoneInfoBox(4, 96, {
				id:   "zone_tundra",
				name: "Tundra",
				icon: ResourceDb.gfx_ZoneIconTundra,
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