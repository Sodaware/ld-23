package ui 
{
	import objects.PlayerRobot;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import db.ResourceDb;
	import components.MoveableObjectComponent;
	import util.*;
	import objects.GameObject;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class PlayerIndicator extends FlxGroup
	{
		
		private var _player:PlayerRobot;
		private var _sprite:GameObject;
		
		public function PlayerIndicator(player:PlayerRobot) 
		{
			super(0);
			
			this._player = player;
			
			this._sprite = new GameObject(player.x, player.y);
			this._sprite.loadGraphic(ResourceDb.gfx_Indicator, true, false, 16, 16);
			this._sprite.addAnimation("stand_up", [0]);
			this._sprite.addAnimation("stand_right", [1]);
			this._sprite.addAnimation("stand_down", [2]);
			this._sprite.addAnimation("stand_left", [3]);
			
			this._sprite.play("stand_down");
			this.add(this._sprite);
		}
		
		public function refresh() : void
		{
			this._sprite.x = this._player.x;
			this._sprite.y = this._player.y;
			this._sprite.setDirection(this._player.getDirection());
			
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			var actions:ActionQueue = playerQueueComponent.getActions();
			
			
			for each (var action:EntityAction in actions.getElements()) {
				action.evaluate(this._sprite);
			}
		}
		
	}

}