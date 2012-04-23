package overlays 
{
	import db.ResourceDb;
	import flash.automation.KeyboardAutomationAction;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import db.ContentDb;
	import db.SessionDb;
	import ui.BestiaryIcon;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class BestiaryScreenOverlay extends ModalScreenOverlay 
	{
		
		private var _buttons:FlxGroup;
		
		
		
		public function BestiaryScreenOverlay() 
		{
			this._title = new FlxText(0, 2, FlxG.width, "Bestiary");
			this._title.alignment = "center";
			this._title.size = 16;
			this.add(this._title);
			
			var xOff:int = 6; var yOff:int = 34;
			
			this._buttons = new FlxGroup;
			for (var obj:String in SessionDb.bestiaryStatus) {
				
				var holder:BestiaryIcon = new BestiaryIcon(xOff, yOff, obj.toString());
				holder.onClickHandler = this.Handle_onBeastClick;
				xOff += 26;
				if (xOff >= 132) {
					xOff = 4; yOff += 26;
				}
				
				this._buttons.add(holder);
			}
			
			this.add(this._buttons);
		}
		
		public function Handle_onBeastClick(args:BestiaryIcon) : void
		{
			this.hide();
			this._clicked = args.getAnimalId();
		}
		
	}

}