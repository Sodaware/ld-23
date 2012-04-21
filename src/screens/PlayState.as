package screens 
{
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxTilemap;
	
	import db.*;
	
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
		protected var _player:FlxSprite;
		
		
		// ----------------------------------------------------------------------
		// -- Creation / Destruction
		// ----------------------------------------------------------------------
		
		public function PlayState() 
		{
			
			FlxG.camera = new FlxCamera(0, 0, 160, 118);
			
			this.backLayer	= new FlxGroup();
			this.uiLayer = new FlxGroup();
			
			this._map = new FlxTilemap();
			this._map.loadMap(new ResourceDb.map_Temperate1, ResourceDb.gfx_TemperateTiles, 16, 16);
			
			this._player = new FlxSprite(32, 32);
			this._player.loadGraphic(ResourceDb.gfx_Player, true, false, 16, 16);
			this._player.addAnimation("walk_down", [0, 1], 4);
			this._player.addAnimation("walk_right", [2, 3], 4);
			this._player.addAnimation("walk_left", [4, 5], 4);
			this._player.addAnimation("walk_up", [6, 7], 4);
			
			this._player.play("walk_down");
			
			this.backLayer.add(this._map);
			this.backLayer.add(this._player);
			
			
			
			
			// UI
			this.overlay = new FlxSprite(0, 0, ResourceDb.gfx_Overlay);
			this.uiLayer.add(this.overlay);
			
			this.add(this.backLayer);
			this.add(this.uiLayer);

			FlxG.camera.follow(this._player);
			
		}
		
	}

}