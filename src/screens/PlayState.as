package screens 
{
	import mx.core.FlexSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxButton;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTilemap;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	import ui.MovementButton;
	import util.ActionQueue;
	import util.actions.MoveEntityAction;
	import util.EntityAction;
	
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
		
		
		protected var overlay:FlxSprite;
		
		// Objects
		protected var _map:FlxTilemap;
		protected var _player:PlayerRobot;
		protected var _queueButtons:Array;
		protected var _goButton:FlxButton;
		
		protected var _help:FlxText;
		protected var _currentQueue:Array;
		
		protected var _queue:ActionQueue;
		
		
		private function Handle_movementClick() : void
		{
			var button:FlxSprite = this._queueButtons[0];
			button.play("button_play");
		//	this._queue.push(new MoveEntityAction(ContentDb.ACTION_MOVE_FORWARD));
			this._player.addAction(new MoveEntityAction(ContentDb.ACTION_MOVE_FORWARD));
		}
		
		private function Handle_onGoClick() : void
		{
//			this._player.play("walk_down");
//			this._help.text = "MOVING!";

			// Update all items that have MoveableObject component
			var objectList:Array = GameObjectDb.getObjectsWithComponent(MoveableObjectComponent);
			for each (var object:GameObject in objectList) {
				var cmp:MoveableObjectComponent = MoveableObjectComponent(object.getComponent(MoveableObjectComponent));
				cmp.executeQueue();
			}
			
			// Update each action in turn
			//this._queue.execute();
			
		}
		
		
		// ----------------------------------------------------------------------
		// -- Creation / Destruction
		// ----------------------------------------------------------------------
		
		public function PlayState() 
		{
			this._queue = new ActionQueue();
			
			this._currentQueue = [0, 0, 0, 0, 0, 0, 0, 0, 0];
			this._queueButtons = [null, null, null, null, null, null, null, null, null, null];
			FlxG.camera = new FlxCamera(0, 0, 160, 118);
			
			FlxG.mouse.load(ResourceDb.gfx_Cursor, 2);
			
			this.backLayer	= new FlxGroup();
			this.uiLayer = new FlxGroup();
			
			this._map = new FlxTilemap();
			this._map.loadMap(new ResourceDb.map_Temperate1, ResourceDb.gfx_TemperateTiles, 16, 16);
			
			this._player = new PlayerRobot(32, 32);
			GameObjectDb.add(this._player);
			
			
			this.backLayer.add(this._map);
			this.backLayer.add(this._player);
			
			// UI
			this.overlay = new FlxSprite(0, 118, ResourceDb.gfx_Overlay);
			this.uiLayer.add(this.overlay);

			
			// Add Queue
			for (var i:int = 0; i < SessionDb.QueueSize; i++) {
				var button:FlxSprite = new FlxSprite(1 + (17 * i), 120);
				button.loadGraphic(ResourceDb.gfx_MovementButtons, true, false, 16, 16);
				button.addAnimation("button_empty", [0]);
				button.addAnimation("button_play", [1]);
				button.play("button_empty");
				this.uiLayer.add(button);
				
				this._queueButtons[i] = button;
			}
			
			this._help = new FlxText(2, 104, 120, "");

			// Add buttons
			var forward:MovementButton = new MovementButton(1, 136, this.Handle_movementClick, this._help, "Move Forward");
			this._goButton = new FlxButton(127, 120, "", this.Handle_onGoClick);
			this._goButton.loadGraphic(ResourceDb.gfx_GoButton, true, false, 32, 13);
			
			
			this.uiLayer.add(forward);
			
			
			this.uiLayer.add(this._goButton);	
			this.uiLayer.add(this._help);
			
			this.add(this.backLayer);
			this.add(this.uiLayer);

			FlxG.camera.follow(this._player);
			
		}
		
	}

}