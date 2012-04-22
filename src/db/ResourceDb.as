package db 
{
	/**
	 * 
	 * 
	 * @author Phil Newton
	 */
	public class ResourceDb 
	{		
		[Embed(source = "../../content/ui/title.png")] public static var gfx_Title:Class;
		
		// Sounds
		[Embed(source = "../../content/sounds/walk.mp3")] public static var snd_Step:Class;
		
		// Sprites etc
		[Embed(source = "../../content/sprites/player.png")] public static var gfx_Player:Class;
		[Embed(source = "../../content/sprites/evil_robot.png")] public static var gfx_EvilRobot:Class;
		
		// Bullets / Explosions
		[Embed(source = "../../content/sprites/bullet.png")] public static var gfx_Bullet:Class;
		
		// User Interface
		[Embed(source = "../../content/ui/overlay.png")] public static var gfx_Overlay:Class;	
		[Embed(source = "../../content/ui/movement-buttons.png")] public static var gfx_MovementButtons:Class;
		[Embed(source = "../../content/ui/button-go.png")] public static var gfx_GoButton:Class;
		
		// Single Buttons
		[Embed(source = "../../content/ui/button-forward.png")] public static var gfx_ButtonForward:Class;
		[Embed(source = "../../content/ui/button-turn_left.png")] public static var gfx_ButtonTurnLeft:Class;
		[Embed(source = "../../content/ui/button-turn_right.png")] public static var gfx_ButtonTurnRight:Class;
		[Embed(source = "../../content/ui/button-step_left.png")] public static var gfx_ButtonStepLeft:Class;
		[Embed(source = "../../content/ui/button-step_right.png")] public static var gfx_ButtonStepRight:Class;
		
		[Embed(source = "../../content/ui/button-fire_weapon.png")] public static var gfx_ButtonFireWeapon:Class;


		[Embed(source = "../../content/ui/cursor.png")] public static var gfx_Cursor:Class;
		[Embed(source = "../../content/ui/icon-current_move.png")] public static var gfx_CurrentMoveIcon:Class;
		[Embed(source = "../../content/ui/indicator.png")] public static var gfx_Indicator:Class;
		
		[Embed(source = "../../content/ui/range-overlay.png")] public static var gfx_RangeOverlay:Class;

		
		
		// Tilesets
		[Embed(source = "../../content/tiles/temperate.png")] public static var gfx_TemperateTiles:Class;
		
		// Maps
		[Embed(source = "../../content/maps/temperate-1.txt", mimeType = "application/octet-stream")] public static var map_Temperate1:Class;
		
	}

}