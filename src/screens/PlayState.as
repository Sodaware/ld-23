package screens 
{
	import events.DamageEvent;
	import events.GameEventDispatcher;
	import events.MoveCompleteEvent;
	import events.TurnStartEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.ID3Info;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxParticle;
	import org.flixel.FlxU;
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import particles.FlyoffParticle;

	import ui.*;
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
		protected var movementButtons:FlxGroup;
		
		// UI Objects
		public var _infoWindow:InfoWindow;
		public var _textBox:MessageBox;
		
		protected var overlay:FlxSprite;
		protected var _indicator:PlayerIndicator;
		protected var _queueButtons:Array;
		protected var _goButton:FlxButton;
		protected var _rangeGrid:RangeGrid;
		
		protected var _enemy:GameObject;
		
		// Level
		protected var _map:FlxTilemap;
		
		// Player
		protected var _player:PlayerRobot;
		
		protected var _help:FlxText;
		protected var _currentQueue:Array;
		
		protected var _queue:ActionQueue;
		protected var _currentMove:FlxSprite;
		
		// State
		private var _targetModeEnabled:Boolean = false;
		private var _scanModeEnabled:Boolean = false;
		
		
		// ----------------------------------------------------------------------
		// -- Main game logic
		// ----------------------------------------------------------------------
		
		override public function update():void 
		{
			
			super.update();
			
			// Handle attack mode / scan mode
			if (this._targetModeEnabled)	updateTargetMode();
			if (this._scanModeEnabled) 		updateScanMode();
			
		}
		
		public function enableMovementButtons() : void
		{
			for each (var button:MovementButton in this.movementButtons.members) {
				button.alpha	= 1.0;
				button.active 	= true;
				button.color	= 0xFFFFFFFF;
			}
		}
		
		public function disableMovementButtons() : void
		{
			for each (var button:MovementButton in this.movementButtons.members) {
				button.alpha	= 0.8;
				button.active 	= false;
				button.color	= 0xFF999999;
			}
		}
		
		public function disableTargetMode() : void
		{
			this._targetModeEnabled = false;
			
			this.backLayer.remove(this._rangeGrid);
			this.uiLayer.remove(this._textBox);
				
			this._rangeGrid.destroy();
			this._textBox.destroy();
		}
		
		public function disableScanMode() : void
		{
			this._scanModeEnabled = false;
			
			this.backLayer.remove(this._rangeGrid);
			this.uiLayer.remove(this._textBox);
				
			this._rangeGrid.destroy();
			this._textBox.destroy();
		}

		
		private function _addActionToPlayer(movementType:int, movementName:String) : void
		{
			var playerQueueComponent:MoveableObjectComponent = this._player.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			
			if (playerQueueComponent.isFull()) {
				// play a sound?
				return;
			}
			
			// Create the action
			var action:EntityAction = EntityActionFactory.create(movementType);
			action.attach(this._player);
			if (!action.canPerform(this._indicator.getSpriteObject())) {
				this.add(new AlertBox("Invalid Move", 36, 10, 76, 22));
				return;
			}

			var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
			button.play(movementName);
			
			playerQueueComponent.addAction(action);
			this._indicator.refresh();
			
		}
		
		
		// ----------------------------------------------------------------------
		// -- Event Handlers
		// ----------------------------------------------------------------------
		
		/**
		 * Triggered when something is damaged. Generates a little flyoff.
		 * @param	e
		 */
		public function Handle_onDamageEvent(e:DamageEvent) : void
		{
			var flyOff:FlyoffParticle = new FlyoffParticle(e.getDamage().toString(), e.getEntity().x, e.getEntity().y);
			this.uiLayer.add(flyOff);
			
			// Check if item was destroyed
			if (e.isFatal()) {
				
				// Was it the player?
				if (e.getEntity() == this._player) {
					
					// Clear all action queues
					for each (var entity:GameObject in GameObjectDb.getObjectsWithComponent(MoveableObjectComponent)) {
						var entityQueue:MoveableObjectComponent = entity.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
						entityQueue.clear()
					}
					
					
					
				}
				
			}
			
		}
		
		/**
		 * Triggered when the player's movement queue is empty.
		 * @param	player
		 */
		public function Handle_onPlayerQueueEmpty(player:GameObject) : void
		{
			for (var i:int = 0; i < this._queueButtons.length; i++) {
				if (this._queueButtons[i] != null) {
					FlxSprite(this._queueButtons[i]).play("button_empty");
				}
			}
			
			// Re-enable the go button
			this._goButton.active		= true;
			this._goButton.alpha		= 1.0;
			this._goButton.color		= 0xFFFFFFFF;
			
			// Re-enable movement
			this.enableMovementButtons();
			
			// Toggle UI elements
			this._indicator.visible		= true;
			this._currentMove.visible	= false;
		}
		
		/**
		 * Triggered when a single player action has completed (such as a step forward).
		 * @param	e
		 */
		public function Handle_onPlayerMoveCompleted(e:MoveCompleteEvent) : void
		{
			// Ignore event from enemies
			if (e.getEntity() != this._player) {
				return;
			}
			
			// Adjust movement indicator
			this._currentMove.x += 17;
		}
		
		
		// ----------------------------------------------------------------------
		// -- Button click handlers
		// ----------------------------------------------------------------------
		
		/**
		 * Handles a click of the "GO" button
		 */
		private function Handle_onGoClick() : void
		{
			
			// Let other objects know the player will be moving
			GameEventDispatcher.getInstance().dispatchEvent(new TurnStartEvent(this._player));
			
			// Check there are items in the player queue
			var playerMovement:MoveableObjectComponent = this._player.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (playerMovement.getSize() == 0) {
				return;
			}
			
			// Disable GO button
			this._goButton.active		= false;
			this._goButton.alpha		= 0.8;
			this._goButton.color		= 0xFF999999;
			
			// Disable all other buttons
			this.disableMovementButtons();
			
			// Hide the movement indicator
			this._indicator.visible		= false;
			
			// Show the current move indicator
			this._currentMove.visible	= true;
			this._currentMove.x			= 1;
			
			// Update all items that have MoveableObject component
			var objectList:Array		= GameObjectDb.getObjectsWithComponent(MoveableObjectComponent);
			for each (var object:GameObject in objectList) {
				var cmp:MoveableObjectComponent = object.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
				cmp.executeQueue();
			}
			
		}
		
		private function Handle_buttonFireWeaponClick() : void
		{
			// Check palyer can target anything
			var playerQueueComponent:MoveableObjectComponent = this._player.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (playerQueueComponent.isFull()) {
				// play a sound?
				return;
			}
			
			// Check for enemies in range
			var somethingInRange:Boolean = false;
			
			// TODO: Update this to use range of the equipped weapon (when/if different weapons get added)
			this._rangeGrid = new RangeGrid(this._indicator.getSpriteObject(), 2, 0xFF2222);
			this.backLayer.add(this._rangeGrid);
			
			for each (var enemy:GameObject in GameObjectDb.getObjectsWithComponent(ShootableComponent)) {
				if (this._player != enemy && this._rangeGrid.isObjectInGrid(enemy)) {
					somethingInRange = true;
				}
			}
			
			if (!somethingInRange) {
				this.uiLayer.add(new AlertBox("Nothing in Range", 36, 10, 92, 22));
				this.backLayer.remove(this._rangeGrid);
				this._rangeGrid.destroy();
				return;
			}
			
			this._textBox = new MessageBox("Select Target", 48, 10, 80, 22);
			this.uiLayer.add(this._textBox);
			this._targetModeEnabled = true;
			
		}
		
		private function Handle_buttonScanObjectClick() : void
		{
			// Check palyer can target anything
			var playerQueueComponent:MoveableObjectComponent = this._player.getComponent(MoveableObjectComponent) as MoveableObjectComponent;
			if (playerQueueComponent.isFull()) {
				// play a sound?
				return;
			}
			
			// Check for animals in range
			var somethingInRange:Boolean = false;
			
			// TODO: Update this to use range of the equipped weapon (when/if different weapons get added)
			this._rangeGrid = new RangeGrid(this._indicator.getSpriteObject(), 4, 0x22FF22);
			this.backLayer.add(this._rangeGrid);
			
			for each (var animal:GameObject in GameObjectDb.getObjectsWithComponent(ScannableComponent)) {
				if (this._player != animal && this._rangeGrid.isObjectInGrid(animal)) {
					somethingInRange = true;
				}
			}
			
			if (!somethingInRange) {
				this.uiLayer.add(new AlertBox("Nothing in Range", 36, 10, 92, 22));
				this.backLayer.remove(this._rangeGrid);
				this._rangeGrid.destroy();
				return;
			}
			
			this._textBox = new MessageBox("Select Target", 48, 10, 80, 22);
			this.uiLayer.add(this._textBox);
			this._scanModeEnabled = true;
			
		}
		
		/**
		 * Called the "move forward" button is clicked
		 */
		private function Handle_buttonMoveForwardClick() : void
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
		
		
		// ----------------------------------------------------------------------
		// -- Creation / Setup
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
			this._player.tag = "player";
			this._player.setMap(this._map);
			
			var cmp:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
			cmp.onQueueEmpty = Handle_onPlayerQueueEmpty;
			
			GameObjectDb.add(this._player);
			this._indicator = new PlayerIndicator(this._player);
			
			// this.backLayer.add(this._player);
			
		}
		
		private function disableInfoWindow():void 
		{
			this.remove(this._infoWindow);
			this._infoWindow.destroy();
			this._infoWindow = null;
		}
		
		private function updateTargetMode():void 
		{
			var enemyOver:GameObject = this.getHoverObject(ShootableComponent);
			if (enemyOver) {
				
				if (!this._infoWindow) {
					this._infoWindow = new InfoWindow(enemyOver, 0, 118, 160, 34);
					this.add(this._infoWindow);
				}
				
				if (FlxG.mouse.pressed()) {
					if (this._rangeGrid.isObjectInGrid(enemyOver)) {
						// Select as target
						var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
						var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
						button.play("button_use_weapon");
						playerQueueComponent.addAction(EntityActionFactory.create(ContentDb.ACTION_SHOOT, {target: enemyOver}));
						this._indicator.refresh();
						this.disableTargetMode();
						this.disableInfoWindow();
						
					} else {
						this.add(new AlertBox("Not in range", 36, 10, 92, 22));
					}
				}
				
			} else {
				if (this._infoWindow) {
					this.disableInfoWindow();
				}
				
				if (FlxG.mouse.pressed()) {
					this.disableTargetMode();
				}
			}
		}
		
		
		
		private function updateScanMode():void 
		{
			var animalOver:GameObject = this.getHoverObject(ScannableComponent);
			
			if (animalOver) {
				
				if (!this._infoWindow) {
					this._infoWindow = new InfoWindow(animalOver, 0, 118, 160, 34);
					this.add(this._infoWindow);
				}
				
				if (FlxG.mouse.pressed()) {
					if (this._rangeGrid.isObjectInGrid(animalOver)) {
						// Select as target
						var playerQueueComponent:MoveableObjectComponent = MoveableObjectComponent(this._player.getComponent(MoveableObjectComponent));
						var button:FlxSprite = this._queueButtons[playerQueueComponent.getSize()];
						button.play("button_use_scanner");
						playerQueueComponent.addAction(EntityActionFactory.create(ContentDb.ACTION_SCAN, {target: animalOver}));
						this._indicator.refresh();
						this.disableScanMode();
						this.disableInfoWindow();
						
					} else {
						this.add(new AlertBox("Not in range", 36, 10, 92, 22));
					}
				}
				
			} else {
				if (this._infoWindow) {
					this.disableInfoWindow();
				}
				
				if (FlxG.mouse.pressed()) {
					this.disableTargetMode();
				}
			}
		}
		
		private function getHoverObject(component:Class) : GameObject
		{
			for each (var entity:GameObject in GameObjectDb.getObjectsWithComponent(component)) {
				
				if (entity.isMouseOver() && entity != this._player) {
					return entity;
				}
			}
			
			return null;
		}
		
		override public function create() : void
		{
			// Moose
			FlxG.mouse.load(ResourceDb.gfx_Cursor, 2);
			
			this.setupActionQueue();
			this.setupBackground();
			this.setupPlayer();
			this.setupCamera();
			
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_DAMAGE, this.Handle_onDamageEvent);
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_MOVE_COMPLETED, this.Handle_onPlayerMoveCompleted);
			
			
			
			this.uiLayer = new FlxGroup();
			//this.uiLayer.add(this._indicator);
			
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
			this.movementButtons = new FlxGroup();
			
			var forward:MovementButton		= new MovementButton(18, 136, ResourceDb.gfx_ButtonForward, this.Handle_buttonMoveForwardClick, this._help, "Move Forward");
			var turnRight:MovementButton	= new MovementButton(35, 136, ResourceDb.gfx_ButtonTurnRight, this.Handle_buttonTurnRightClick, this._help, "Turn Right");
			var turnLeft:MovementButton		= new MovementButton(1, 136, ResourceDb.gfx_ButtonTurnLeft, this.Handle_buttonTurnLeftClick, this._help, "Turn Left");

			var stepLeft:MovementButton		= new MovementButton(52, 136, ResourceDb.gfx_ButtonStepLeft, this.Handle_buttonStepLeftClick, this._help, "Step Left");
			var stepRight:MovementButton	= new MovementButton(69, 136, ResourceDb.gfx_ButtonStepRight, this.Handle_buttonStepRightClick, this._help, "Step Right");
			
			var fireWeapon:MovementButton	= new MovementButton(86, 136, ResourceDb.gfx_ButtonFireWeapon, this.Handle_buttonFireWeaponClick, this._help, "Fire Weapon");
			var scanObject:MovementButton	= new MovementButton(103, 136, ResourceDb.gfx_ButtonScanObject, this.Handle_buttonScanObjectClick, this._help, "Scan Object");
			
			this.movementButtons.add(forward);
			this.movementButtons.add(turnRight);
			this.movementButtons.add(turnLeft);
			this.movementButtons.add(stepLeft);
			this.movementButtons.add(stepRight);
			this.movementButtons.add(fireWeapon);
			this.movementButtons.add(scanObject);
			
			// GO button!
			this._goButton = new FlxButton(127, 120, "", this.Handle_onGoClick);
			this._goButton.loadGraphic(ResourceDb.gfx_GoButton, true, false, 32, 13);
			
			// Movement indicator
			this._currentMove = new FlxSprite(1, 121, ResourceDb.gfx_CurrentMoveIcon);
			this._currentMove.visible = false;
			this._currentMove.alpha = 0.4;
		
			this.uiLayer.add(forward);
			this.uiLayer.add(turnRight);
			this.uiLayer.add(turnLeft);
			this.uiLayer.add(stepLeft);
			this.uiLayer.add(stepRight);
			
			this.uiLayer.add(fireWeapon);
			this.uiLayer.add(scanObject);
			this.uiLayer.add(this._currentMove);
			
			this.uiLayer.add(this._goButton);	
			this.uiLayer.add(this._help);
			
			this.uiLayer.add(this._indicator);
			
			for each (var item:MovementButton in this.movementButtons.members) {
				ObjectUtil.lock(item);
			}
			
			// Lock entities
			ObjectUtil.lock(this._goButton, this._help, this._currentMove, this.overlay);
			
			this.add(this.backLayer);
			this.add(GameObjectDb.getGroup());
			this.add(this.uiLayer);
			
			this.uiLayer.add(this._currentMove);
			
			// Temp code
			this._enemy = new EvilRobotObject(32, 64, ResourceDb.gfx_EvilRobot);
			this._enemy.setMap(this._map);
			GameObjectDb.add(this._enemy);
			
			var aminal:AnimalObject = new AnimalObject(64, 64, {
				name: "BushMan",
				sprite: ResourceDb.gfx_AnimalBushman
			});
			aminal.setMap(this._map);
			GameObjectDb.add(aminal);

			var crate:CrateObject = new CrateObject(16, 32, ResourceDb.gfx_Crate);
			crate.setMap(this._map);
			GameObjectDb.add(crate);
			this.backLayer.add(crate);

			
			// FlxG.camera.follow(this._player);
			
		}
		
	}

}