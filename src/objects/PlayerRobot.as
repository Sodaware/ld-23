package objects 
{
	import components.*;
	import org.flixel.FlxSprite;
	import db.ResourceDb;
	import util.EntityAction;
	
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class PlayerRobot extends GameObject
	{
		
		private var _movement:MoveableObjectComponent;
		
		public function PlayerRobot(xPos:int, yPos:int)
		{
			super(xPos, yPos);
			
			this._movement = new MoveableObjectComponent();
			
			this.addComponent(this._movement);
			
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
		
		public function addAction(action:EntityAction) : void 
		{
			this._movement.addAction(action);
		}
		
	}

}