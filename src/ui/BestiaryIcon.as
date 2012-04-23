package ui 
{
	import db.ContentDb;
	import db.ResourceDb;
	import db.SessionDb;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class BestiaryIcon extends ClickableGroup 
	{
		
		private var _bg:FlxSprite;
		private var _icon:FlxSprite;
		private var _animal:String;
		private var _hoverEffects:Boolean = true;
		
		public function BestiaryIcon(xPos:int, yPos:int, animalType:String) 
		{
			
			// Get beast
			var beastInfo:Object = ContentDb.animalData[animalType];
			
			// Setup
			this._animal = animalType;
			
			// Draw icon holder
			this._bg	= new FlxSprite(xPos, yPos, ResourceDb.gfx_IconBackground);
			
			// Icon
			this._icon	= new FlxSprite(xPos + 4, yPos + 4);
			
			if (SessionDb.bestiaryStatus[animalType]) {
				this._icon.loadGraphic(beastInfo["sprite"], true, false, 16, 16);
				this._icon.addAnimation("stand", [0, 1], 2);
				this._icon.play("stand");
			} else {
				this._icon.loadGraphic(ResourceDb.gfx_IconUnknown);
			}
			
			this.add(this._bg);
			this.add(this._icon);
			
			this._bg.color = 0xFFCCCCCC;
			this._icon.color = 0xFFCCCCCC;
			
			
			this.setDimensions(xPos, yPos, this._bg.width, this._bg.height);
			
			this.onEnterHandler = this.Handle_onEnter;
			this.onLeaveHandler = this.Handle_onLeave;
			
		}
		
		public function disableHoverEffects() : void
		{
			this._hoverEffects = false;
			this._bg.color = 0xFFFFFFFF;
			this._icon.color = 0xFFFFFFFF;
		}
		
		public function Handle_onEnter(args:BestiaryIcon) : void
		{
			if (!this._hoverEffects) return;
			this._bg.color = 0xFFFFFFFF;
			this._icon.color = 0xFFFFFFFF;
		}
		
		public function Handle_onLeave(args:BestiaryIcon) : void
		{
			if (!this._hoverEffects) return;
			this._bg.color = 0xFFCCCCCC;
			this._icon.color = 0xFFCCCCCC;
		}

		public function getAnimalId() : String
		{
			return this._animal;
		}
		
	}

}