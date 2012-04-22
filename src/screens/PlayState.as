package screens 
{
	import mx.core.FlexSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import ui.MovementButton;
	import ui.PlayerIndicator;
	import util.*;
	
	import db.*;
	import objects.*;
	import components.*;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class PlayState extends FlxState 
	{
		// Layers
		protected var backLayer:FlxGroup;
		protected var uiLayer:FlxGroup;
		protected var _indicator:PlayerIndicator;
		
		protected var overlay:FlxSprite;
		
		// Objects
		protected var _map:FlxTilemap;
		protected var _player:PlayerRobot;
		protected var _queueButtons:Array;
		protected var _goButton:FlxButton;
		
		protected var _help:FlxText;
		protected var _currentQueue:Array;
		
		protected var _queue:ActionQueue;
		protected var _currentMove:FlxSprite;
		
		private function Handle_movementClick() : void
		{
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			
			if (playerQueueComponent.isFull()) {
				return;
			}
			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play("button_forward");
		//	this._queue.push(new MoveEntityAction(ContentDb.ACTION_MOVE_FORWARD));
			this._player.addAction(EntityActionFactory.create(ContentDb.ACTION_MOVE_FORWARD));
			this._indicator.refresh();
		}

		private function Handle_buttonTurnRightClick() : void
		{
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play("button_turn_right");
		//	this._queue.push(new MoveEntityAction(ContentDb.ACTION_MOVE_FORWARD));
			this._player.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_RIGHT));
			this._indicator.refresh();
		}

		private function Handle_buttonTurnLeftClick() : void
		{
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play("button_turn_left");
		//	this._queue.push(new MoveEntityAction(ContentDb.ACTION_MOVE_FORWARD));
			this._player.addAction(EntityActionFactory.create(ContentDb.ACTION_TURN_LEFT));
			this._indicator.refresh();
		}

		
		
		private function Handle_onGoClick() : void
		{
			// Update all items that have MoveableObject component
			var objectList:Array = GameObjectDb.getObjectsWithComponent(MoveableObjectComponent);
			
			for each (var object:GameObject in objectList) {
				var cmp:MoveableObjectComponent = MoveableObjectComponent(object.getComponent(MoveableObjectComponent));
				cmp.executeQueue(this.Handle_onMoveComplete);
			}
			
			// Update each action in turn
			//this._queue.execute();
			
		}
		
		public function Handle_onMoveComplete(e:GameObject) : void
		{
			
		}
		
		
		// ----------------------------------------------------------------------
		// -- Creation / Destruction
		// ----------------------------------------------------------------------
		
		override public function create() : void
		{
			var camera:FlxCamera = new FlxCamera(0, 0, 160, 152);
			
			
			
			this._queue = new ActionQueue();
			
			this._currentQueue = [0, 0, 0, 0, 0, 0, 0, 0, 0];
			this._queueButtons = [null, null, null, null, null, null, null, null, null, null];
			
			
			FlxG.mouse.load(ResourceDb.gfx_Cursor, 2);
			
			this.backLayer	= new FlxGroup();
			this.uiLayer = new FlxGroup();
			
			this._map = new FlxTilemap();
			this._map.loadMap(new ResourceDb.map_Temperate1, ResourceDb.gfx_TemperateTiles, 16, 16);
			
			FlxG.worldBounds = new FlxRect(0, 0, this._map.width, this._map.height);
			
			camera.setBounds(0, 0, this._map.width, this._map.height);
			
			this._player = new PlayerRobot(32, 32);
			this._player.setMap(this._map);
			GameObjectDb.add(this._player);
			this._indicator = new PlayerIndicator(this._player);
			
			camera.follow(this._player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			
			this.backLayer.add(this._map);
			this.backLayer.add(this._player);
			this.backLayer.add(this._indicator);
			
			// UI
			this.overlay = new FlxSprite(0, 118, ResourceDb.gfx_Overlay);
			this.uiLayer.add(this.overlay);
			
			
			// Add Queue
			for (var i:int = 0; i < SessionDb.QueueSize; i++) {
				var button:FlxSprite = new FlxSprite(1 + (17 * i), 120);
				button.loadGraphic(ResourceDb.gfx_MovementButtons, true, false, 16, 16);
				button.addAnimation("button_empty", [0]);
				button.addAnimation("button_forward", [1]);
				button.addAnimation("button_turn_left", [3]);
				button.addAnimation("button_turn_right", [4]);
				button.play("button_empty");
			
				button.scrollFactor.x = button.scrollFactor.y = 0;
				this.uiLayer.add(button);
				
				this._queueButtons[i] = button;
			}
			
			this._help = new FlxText(2, 104, 120, "");

			// Add buttons
			var forward:MovementButton = new MovementButton(1, 136, ResourceDb.gfx_ButtonForward, this.Handle_movementClick, this._help, "Move Forward");
			var turnRight:MovementButton = new MovementButton(18, 136, ResourceDb.gfx_ButtonTurnRight, this.Handle_buttonTurnRightClick, this._help, "Turn Right");
			var turnLeft:MovementButton = new MovementButton(34, 136, ResourceDb.gfx_ButtonTurnLeft, this.Handle_buttonTurnLeftClick, this._help, "Turn Left");

			this._goButton = new FlxButton(127, 120, "", this.Handle_onGoClick);
			this._goButton.loadGraphic(ResourceDb.gfx_GoButton, true, false, 32, 13);
			
			this._currentMove = new FlxSprite(1, 121, ResourceDb.gfx_CurrentMoveIcon);
			this._currentMove.visible = false;
			
		
			this.uiLayer.add(forward);
			this.uiLayer.add(turnRight);
			this.uiLayer.add(turnLeft);
			
			
			this.uiLayer.add(this._goButton);	
			this.uiLayer.add(this._help);
			
			for each (var item:FlxSprite in this.uiLayer.members) {
				item.scrollFactor.x = item.scrollFactor.y = 0;
			}
			
			this.add(this.backLayer);
			this.add(this.uiLayer);
			
			this.uiLayer.add(this._currentMove);
			
			FlxG.resetCameras(camera);

			
			// FlxG.camera.follow(this._player);
			
		}
		
	}

}