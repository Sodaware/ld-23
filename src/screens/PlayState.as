package screens 
{
	import org.flixel.FlxGroup;
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
		
		// Objects
		protected var _map:FlxTilemap;
		
		// ----------------------------------------------------------------------
		// -- Creation / Destruction
		// ----------------------------------------------------------------------
		
		public function PlayState() 
		{
			this.backLayer	= new FlxGroup();
			
			this._map = new FlxTilemap();
			this._map.loadMap(new ResourceDb.map_Temperate1, ResourceDb.gfx_TemperateTiles, 16, 16);
			
			this.backLayer.add(this._map);
			// this.backLayer.add(this._player);
			
			this.add(this.backLayer);

		}
		
	}

}