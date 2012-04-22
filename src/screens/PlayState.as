package screens 
{
	import flash.media.ID3Info;
	import mx.core.FlexSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxU;
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
		protected var _enemy:GameObject;
		
		// Objects
		protected var _map:FlxTilemap;
		protected var _player:PlayerRobot;
		protected var _queueButtons:Array;
		protected var _goButton:FlxButton;
		
		protected var _help:FlxText;
		protected var _currentQueue:Array;
		
		protected var _queue:ActionQueue;
		protected var _currentMove:FlxSprite;
		protected var _rangeGrid:RangeGrid;
		
		public var onQueueEmpty:Function;
		
		private function _addActionToPlayer(movementType:int, movementName:String) : void
		{
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			
			if (playerQueueComponent.isFull()) {
				// play a sound?
				return;
			}
			
			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play(movementName);
			this._player.addAction(EntityActionFactory.create(movementType));
			this._indicator.refresh();
			
		}
		
		private function Handle_movementClick() : void
		{
			this._addActionToPlayer(ContentDb.ACTION_MOVE_FORWARD, "button_forward");
		}

		private function Handle_buttonTurnRightClick() : void
		{
			this._addActionToPlayer(ContentDb.ACTION_TURN_RIGHT, "button_turn_right");
		}

		private function Handle_buttonTurnLeftClick() : void
		{
			this._addActionToPlayer(ContentDb.ACTION_TURN_LEFT, "button_turn_left");
		}

		private function Handle_buttonStepLeftClick() : void
		{
			this._addActionToPlayer(ContentDb.ACTION_MOVE_LEFT, "button_step_left");
		}
		
		private function Handle_buttonStepRightClick() : void
		{
			this._addActionToPlayer(ContentDb.ACTION_MOVE_RIGHT, "button_step_right");
		}
		
		private function Handle_buttonFireWeaponClick() : void
		{
			// Check for enemies in range
			
			var somethingInRange:Boolean = false;
			
			// TODO: Update this to use range of the equipped weapon
			this._rangeGrid = new RangeGrid(this._indicator.getSpriteObject(), 2, 0xFF2222);
			this.backLayer.add(this._rangeGrid);
			
			for each (var enemy:GameObject in GameObjectDb.getObjectsWithComponent(EnemyComponent)) {
				if (this._rangeGrid.isObjectInGrid(enemy)) {
					trace("Enemy was in the grid!");
				}
			}
			
			return;
			
			var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
		
			
			
			
			
			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play("button_use_weapon");
			this._player.addAction(EntityActionFactory.create(ContentDb.ACTION_SHOOT, {weapon: "gun"}));
			this._indicator.refresh();
		}
		
		private function Handle_onGoClick() : void
		{
			// Update all items that have MoveableObject component
			var objectList:Array = GameObjectDb.getObjectsWithComponent(MoveableObjectComponent);
			this._indicator.visible = false;
			
			for each (var object:GameObject in objectList) {
				var cmp:MoveableObjectComponent = MoveableObjectComponent(object.getComponent(MoveableObjectComponent));
				cmp.executeQueue();
			}
			
		}
		
		public function Handle_onPlayerQueueEmpty(player:GameObject) : void
		{
			this._indicator.visible = true;
		}
		
		
		// ----------------------------------------------------------------------
		// -- Creation / Destruction
		// ----------------------------------------------------------------------
		
		private function setupActionQueue() : void
		{
			this._queue = new ActionQueue();
			
			this._currentQueue = [0, 0, 0, 0, 0, 0, 0, 0, 0];
			this._queueButtons = [null, null, null, null, null, null, null, null, null, null];
		}
		
		private function setupCamera() : void
		{
			var camera:FlxCamera = new FlxCamera(0, 0, 160, 152);
			camera.setBounds(0, 0, this._map.width, this._map.height);
			camera.follow(this._player, FlxCamera.STYLE_TOPDOWN_TIGHT);
			
			FlxG.resetCameras(camera);
		}
		
		private function setupBackground() : void
		{
			this.backLayer	= new FlxGroup();
			
			// Setup the map
			this._map = new FlxTilemap();
			
			// TODO: Load this from the session
			this._map.loadMap(new ResourceDb.map_Temperate1, ResourceDb.gfx_TemperateTiles, 16, 16);
			
			FlxG.worldBounds = new FlxRect(0, 0, this._map.width, this._map.height);
			
			this.backLayer.add(this._map);
		}
		
		private function setupPlayer() : void
		{
			this._player = new PlayerRobot(32, 32);
			this._player.setMap(this._map);
			
			var cmp:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			cmp.onQueueEmpty = Handle_onPlayerQueueEmpty;
			
			GameObjectDb.add(this._player);
			this._indicator = new PlayerIndicator(this._player);
			
			this.backLayer.add(this._player);
			this.backLayer.add(this._indicator);
		}
		
		override public function create() : void
		{
			this.setupActionQueue();
			this.setupBackground();
			this.setupPlayer();
			this.setupCamera();
			
			FlxG.mouse.load(ResourceDb.gfx_Cursor, 2);
			
			this.uiLayer = new FlxGroup();
			
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
				button.addAnimation("button_step_left", [5]);
				button.addAnimation("button_step_right", [6]);
				button.addAnimation("button_use_scanner", [7]);
				button.addAnimation("button_use_weapon", [8]);
				button.addAnimation("button_use_item", [9]);
				button.play("button_empty");
			
				button.scrollFactor.x = button.scrollFactor.y = 0;
				this.uiLayer.add(button);
				
				this._queueButtons[i] = button;
			}
			
			this._help = new FlxText(2, 104, 120, "");

			// Add buttons
			var forward:MovementButton		= new MovementButton(1, 136, ResourceDb.gfx_ButtonForward, this.Handle_movementClick, this._help, "Move Forward");
			var turnRight:MovementButton	= new MovementButton(18, 136, ResourceDb.gfx_ButtonTurnRight, this.Handle_buttonTurnRightClick, this._help, "Turn Right");
			var turnLeft:MovementButton		= new MovementButton(35, 136, ResourceDb.gfx_ButtonTurnLeft, this.Handle_buttonTurnLeftClick, this._help, "Turn Left");

			var stepLeft:MovementButton		= new MovementButton(52, 136, ResourceDb.gfx_ButtonStepLeft, this.Handle_buttonStepLeftClick, this._help, "Step Left");
			var stepRight:MovementButton	= new MovementButton(69, 136, ResourceDb.gfx_ButtonStepRight, this.Handle_buttonStepRightClick, this._help, "Step Right");
			
			var fireWeapon:MovementButton	= new MovementButton(86, 136, ResourceDb.gfx_ButtonFireWeapon, this.Handle_buttonFireWeaponClick, this._help, "Fire Weapon");
			
			
			this._goButton = new FlxButton(127, 120, "", this.Handle_onGoClick);
			this._goButton.loadGraphic(ResourceDb.gfx_GoButton, true, false, 32, 13);
			
			this._currentMove = new FlxSprite(1, 121, ResourceDb.gfx_CurrentMoveIcon);
			this._currentMove.visible = false;
			
		
			this.uiLayer.add(forward);
			this.uiLayer.add(turnRight);
			this.uiLayer.add(turnLeft);
			this.uiLayer.add(stepLeft);
			this.uiLayer.add(stepRight);
			
			this.uiLayer.add(fireWeapon);
			
			this.uiLayer.add(this._goButton);	
			this.uiLayer.add(this._help);
			
			for each (var item:FlxSprite in this.uiLayer.members) {
				item.scrollFactor.x = item.scrollFactor.y = 0;
			}
			
			this.add(this.backLayer);
			this.add(this.uiLayer);
			
			this.uiLayer.add(this._currentMove);
			
			// Temp code
			this._enemy = new EvilRobotObject(32, 64, ResourceDb.gfx_EvilRobot);
			GameObjectDb.add(this._enemy);
			this.backLayer.add(this._enemy);

			
			// FlxG.camera.follow(this._player);
			
		}
		
	}

}