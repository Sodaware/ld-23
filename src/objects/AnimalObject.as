package objects 
{
	import components.*;
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
	public class AnimalObject extends GameObject
	{
		protected var _movement:MoveableObjectComponent;
		protected var _brain:BrainComponent;
		protected var _body:ShootableComponent;
		protected var _scannable:ScannableComponent;
		
		public function AnimalObject(xPos:int, yPos:int, args:Object)
		{
			super(xPos, yPos);
			
			this._movement = new MoveableObjectComponent();
			this._movement.setMaxSize(4);
			
			this._brain = new BrainComponent();
			
			this._body = new ShootableComponent(10);
			this._body.setName(args["name"]);
			
			this.addComponent(this._movement);
			this.addComponent(this._brain);
			this.addComponent(this._body);
			this.addComponent(new ScannableComponent());
			
			this.loadGraphic(args["sprite"], true, false, 16, 16);
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