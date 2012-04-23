package ui 
{
	
	import db.SessionDb;
	import objects.AnimalObject;
	import objects.GameObject;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	
	import components.*;
	
	public class AnimalInfoWindow extends InfoWindow 
	{
		
		public function AnimalInfoWindow(entity:AnimalObject, xPos:int, yPos:int, width:int, height:int) 
		{
			super(entity, xPos, yPos, width, height);
			
			// If animal has not been scanned before, replace text
			if (!SessionDb.bestiaryStatus[entity.name]) {
				this._hp.visible = false;
				this._hpLabel.visible = false;
				this._title.text = "[Unknown]";
			}
			
			
		}
		
	}

}