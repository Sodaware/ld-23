package ui 
{
	import objects.GameObject;
	import org.flixel.FlxGroup;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxBar;
	
	import components.*;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class InfoWindow extends FlxGroup 
	{
		
		private var _title:FlxText;
		private var _hpLabel:FlxText;
		private var _hp:FlxBar;
		
		public function InfoWindow(entity:GameObject, xPos:int, yPos:int, width:int, height:int) 
		{
			
			// Get components
			var body:ShootableComponent = ShootableComponent(entity.getComponent(ShootableComponent));
			//var inventory:ShootableComponent = ShootableComponent(entity.getComponent(ShootableComponent));
			
			// Create text
			this._title		= new FlxText(xPos + 4, yPos + 4, width / 2, body.getName());
			this._hpLabel	= new FlxText(xPos - 4 + (width / 2), yPos + 4, width / 2, "HP: " + body.health + "/" + body.maxHealth);
			this._hpLabel.alignment = "right";
			
			this._hp	= new FlxBar(xPos + 4, yPos + 24, FlxBar.FILL_LEFT_TO_RIGHT, width - 8, 4);
			this._hp.percent = (body.health / body.maxHealth) * 100;
			this._hp.color 	= 0xFF008000;
			
			var frameOuter:FlxSprite = new FlxSprite(xPos, yPos);
			frameOuter.makeGraphic(width, height, 0xFF2E4B98);
			
			var frameInner:FlxSprite = new FlxSprite(xPos + 2, yPos + 2);
			frameInner.makeGraphic(width - 4, height - 4, 0xFF7892D6);
			
			this.add(frameOuter);
			this.add(frameInner);
			this.add(this._title);
			this.add(this._hpLabel);
			this.add(this._hp);
			
			frameOuter.scrollFactor.x = frameOuter.scrollFactor.y = 0;
			frameInner.scrollFactor.x = frameInner.scrollFactor.y = 0;
			this._title.scrollFactor.x = this._title.scrollFactor.y = 0;
		
		}
		
	}

}