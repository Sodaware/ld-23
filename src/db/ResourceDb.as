package db 
{
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ResourceDb 
	{		
		[Embed(source = "../../content/ui/title.png")] public static var gfx_Title:Class;
		[Embed(source = "../../content/ui/overlay.png")] public static var gfx_Overlay:Class;	
	
		// Sprites etc
		[Embed(source = "../../content/sprites/player.png")] public static var gfx_Player:Class;
		
		// Tilesets
		[Embed(source = "../../content/tiles/temperate.png")] public static var gfx_TemperateTiles:Class;
		
		// Maps
		[Embed(source = "../../content/maps/temperate-1.txt", mimeType = "application/octet-stream")] public static var map_Temperate1:Class;
		
	}

}