package objects 
{
	import components.*;
	import org.flixel.FlxSprite;
	import db.ResourceDb;
	import org.flixel.FlxTilemap;
	import util.EntityAction;
	
	
	/**
	 * Playable robot
	 */
	public class PlayerRobot extends GameObject
	{
		
		private var _movement:MoveableObjectComponent;
		private var _body:ShootableComponent;
		private var _inventory:InventoryComponent;
				
		public function PlayerRobot(xPos:int, yPos:int)
		{
			super(xPos, yPos);
			
			// Set up movement queue
			this._movement = new MoveableObjectComponent();
			this._movement.setMaxSize(4);
			
			// Set up health
			this._body = new ShootableComponent(20);
			
			// Set up inventory
			this._inventory = new InventoryComponent();
			
			// Add components
			this.addComponent(this._movement);
			this.addComponent(this._body);
			this.addComponent(this._inventory);
			
			// Setup GFX
			this.loadGraphic(ResourceDb.gfx_Player, true, false, 16, 16);
			this.addAnimation("stand_down", [0, 1], 2);
			this.addAnimation("stand_right", [2, 3], 2);
			this.addAnimation("stand_left", [4, 5], 2);
			this.addAnimation("standup", [6, 7], 2);
			
			this.addAnimation("walk_down", [0, 1], 4);
			this.addAnimation("walk_right", [2, 3], 4);
			this.addAnimation("walk_left", [4, 5], 4);
			this.addAnimation("walk_up", [6, 7], 4);
			
			this.play("stand_down");
			
	
		}

		
	}

}