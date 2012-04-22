package objects 
{
	import components.EnemyComponent;
	import components.MoveableObjectComponent;
	import components.ShootableComponent;
	import db.ContentDb;
	import db.GameObjectDb;
	import events.GameEventDispatcher;
	import events.TurnStartEvent;
	import flash.events.Event;
	import util.EntityAction;
	import util.EntityActionFactory;
	
	
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
			this._body.setName("Evil Robot");
			
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
			
			// Listen for the "go" button being pressed (so the enemy can calculate moves)
			// Would like to delegate this down to the component level (in the brain section)
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_GO_PRESSED, this.Handle_beforeTurnStart);
			
		}
		
		private function Handle_beforeTurnStart(e:TurnStartEvent) : void
		{
			// Add stuff
			for (var i:int = 0; i < e.playerQueueSize; i++) {
				//this._movement.addAction(EntityActionFactory.create(ContentDb.ACTION_SHOOT, { target: GameObjectDb.find("player") } ));
			}
//			this._movement.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_LEFT));
//			this._movement.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_LEFT));
			
		}
		
	}

}