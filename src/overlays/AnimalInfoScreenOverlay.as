package overlays 
{
	
	import db.*;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import ui.BestiaryIcon;
	
	/**
	 * 
	 */
	public class AnimalInfoScreenOverlay extends ModalScreenOverlay 
	{
		
		private var _bg:FlxSprite;
		
		private var _name:FlxText;
		private var _habitat:FlxText;
		private var _info:FlxText;
		
		private var _icon:BestiaryIcon;
		
		
		public function AnimalInfoScreenOverlay(name:String) 
		{			
			this._title = new FlxText(0, 2, FlxG.width, "Bestiary");
			this._title.alignment = "center";
			this._title.size = 16;
			this.add(this._title);
			
			// Background
			this._bg = new FlxSprite(4, 24, ResourceDb.gfx_BeastiaryWindow);
			this.add(this._bg);
			
			// Get beast
			var beastInfo:Object = ContentDb.animalData[name];
			
			// Add title / icon
			this._name 		= new FlxText(38, 30, 120, "Species: Unknown");
			this._habitat	= new FlxText(38, 42, 120, "Habitat: " + beastInfo["habitat"]);
			this._info		= new FlxText(10, 58, 142, "\n\n..[ data corrupted ]..");
			this._info.alignment = "center";
			
			this._name.color 	= 0xFF737373; this._name.shadow = 0xFFAC9DB3;
			this._habitat.color	= 0xFF737373; this._habitat.shadow = 0xFFAC9DB3;
			this._info.color 	= 0xFF737373; this._info.shadow = 0xFFAC9DB3;
			
			if (SessionDb.bestiaryStatus[name]) {
				this._name.text = "Species: " + beastInfo.name;
				this._info.text = beastInfo["description"];
				this._info.alignment = "left";
			}
			
			this._icon = new BestiaryIcon(10, 30, name);
			this._icon.disableHoverEffects();
			this.add(this._icon);
			
			this.add(this._name);
			this.add(this._habitat);
			this.add(this._info);
			
			this.addBackButton();
			
			this._back.x += 6; this._back.y -= 6;
			
			// Move back button into frame
			
			
			
			
		}
		
		
		
	}

}