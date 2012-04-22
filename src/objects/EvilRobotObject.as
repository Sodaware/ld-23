package objects 
{
	import components.EnemyComponent;
	import components.MoveableObjectComponent;
	import components.ShootableComponent;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class EvilRobotObject extends GameObject
	{
		protected var _movement:MoveableObjectComponent;
		protected var _brain:EnemyComponent;
		protected var _body:ShootableComponent;
		
		public function EvilRobotObject(xPos:int, yPos:int, gfx:Class)
		{
			super(xPos, yPos);
			
			this._movement = new MoveableObjectComponent();
			this._movement.setMaxSize(4);
			
			this._brain = new EnemyComponent();
			
			this._body = new ShootableComponent(10);
			
			this.addComponent(this._movement);
			this.addComponent(this._brain);
			this.addComponent(this._body);
			
			this.loadGraphic(gfx, true, false, 16, 16);
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