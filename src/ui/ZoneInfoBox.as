package ui 
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ZoneInfoBox extends ClickableGroup 
	{
		
		private var _info:Object;
		
		private var _name:FlxText;
		private var _icon:FlxSprite;
		

		
		public function ZoneInfoBox(xPos:int, yPos:int, info:Object) 
		{
			this._info = info;
			
			this.setDimensions(xPos, yPos, FlxG.width - 8, 40);
			
			this._icon = new FlxSprite(xPos + 0, yPos + 4 , info["icon"]);
			this._name = new FlxText(xPos + 36, yPos + 4, 64, info["name"]);
			
			this.add(this._name);
			this.add(this._icon);
			
			if (info["on_click"]) {
				this.onClickHandler = info["on_click"];
			}
		}
		
		
		
		public function getInfo() : Object
		{
			return this._info;
		}
		
	
		
	}

}