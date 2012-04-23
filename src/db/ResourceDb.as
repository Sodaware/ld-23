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
		[Embed(source = "../../content/sprites/ship.png")] public static var gfx_TitleShip:Class;
		
		// Sounds
		[Embed(source = "../../content/sounds/walk.mp3")] public static var snd_Step:Class;
		
		[Embed(source = '../../content/sounds/hit1.mp3')] public static var snd_Hit1:Class;
		[Embed(source = '../../content/sounds/hit2.mp3')] public static var snd_Hit2:Class;
		[Embed(source = '../../content/sounds/hit3.mp3')] public static var snd_Hit3:Class;
		public static var snd_Hits:Array = [snd_Hit1, snd_Hit2, snd_Hit3];
		
		[Embed(source = '../../content/sounds/shoot1.mp3')] public static var snd_Shoot1:Class;
		[Embed(source = '../../content/sounds/shoot2.mp3')] public static var snd_Shoot2:Class;
		[Embed(source = '../../content/sounds/shoot3.mp3')] public static var snd_Shoot3:Class;
		public static var snd_Shots:Array = [snd_Shoot1, snd_Shoot2, snd_Shoot3];
		
		[Embed(source = '../../content/sounds/explosion1.mp3')] public static var snd_Explosion1:Class;
		[Embed(source = '../../content/sounds/explosion2.mp3')] public static var snd_Explosion2:Class;
		[Embed(source = '../../content/sounds/explosion3.mp3')] public static var snd_Explosion3:Class;
		public static var snd_Explosions:Array = [snd_Explosion1, snd_Explosion2, snd_Explosion3];
		
		// Zone icons
		[Embed(source = "../../content/zones/icon-temperate.png")] public static var gfx_ZoneIconTemperate:Class;
		[Embed(source = "../../content/zones/icon-desert.png")] public static var gfx_ZoneIconDesert:Class;
		[Embed(source = "../../content/zones/icon-tundra.png")] public static var gfx_ZoneIconTundra:Class;
		
		// Aminals
		[Embed(source = "../../content/sprites/animal-bushman.png")] public static var gfx_AnimalBushman:Class;
		[Embed(source = "../../content/sprites/animal-space_bear.png")] public static var gfx_AnimalSpaceBear:Class;
		[Embed(source = "../../content/sprites/animal-space_snake.png")] public static var gfx_AnimalSpaceSnake:Class;
		
		// Bestiary Icons
		[Embed(source = "../../content/ui/icon-background.png")] public static var gfx_IconBackground:Class;
		[Embed(source = "../../content/ui/icon-locked.png")] public static var gfx_IconLocked:Class;
		[Embed(source = "../../content/ui/icon-unknown.png")] public static var gfx_IconUnknown:Class;
		
		
		// Sprites etc
		[Embed(source = "../../content/sprites/player.png")] public static var gfx_Player:Class;
		[Embed(source = "../../content/sprites/evil_robot.png")] public static var gfx_EvilRobot:Class;
		[Embed(source = "../../content/sprites/crate.png")] public static var gfx_Crate:Class;
		[Embed(source = "../../content/sprites/bomb.png")] public static var gfx_Bomb:Class;
		
		// Bullets / Explosions
		[Embed(source = "../../content/sprites/bullet.png")] public static var gfx_Bullet:Class;
		
		// User Interface
		[Embed(source = "../../content/ui/overlay.png")] public static var gfx_Overlay:Class;	
		[Embed(source = "../../content/ui/window-info.png")] public static var gfx_BeastiaryWindow:Class;	
		
		[Embed(source = "../../content/ui/movement-buttons.png")] public static var gfx_MovementButtons:Class;
		[Embed(source = "../../content/ui/button-go.png")] public static var gfx_GoButton:Class;
		[Embed(source = "../../content/ui/button-back.png")] public static var gfx_BackButton:Class;
		
		// Single Buttons
		[Embed(source = "../../content/ui/button-forward.png")] public static var gfx_ButtonForward:Class;
		[Embed(source = "../../content/ui/button-turn_left.png")] public static var gfx_ButtonTurnLeft:Class;
		[Embed(source = "../../content/ui/button-turn_right.png")] public static var gfx_ButtonTurnRight:Class;
		[Embed(source = "../../content/ui/button-step_left.png")] public static var gfx_ButtonStepLeft:Class;
		[Embed(source = "../../content/ui/button-step_right.png")] public static var gfx_ButtonStepRight:Class;
		
		[Embed(source = "../../content/ui/button-fire_weapon.png")] public static var gfx_ButtonFireWeapon:Class;
		[Embed(source = "../../content/ui/button-scan_item.png")] public static var gfx_ButtonScanObject:Class;
		[Embed(source = "../../content/ui/button-use_item.png")] public static var gfx_ButtonUseItem:Class;


		[Embed(source = "../../content/ui/cursor.png")] public static var gfx_Cursor:Class;
		[Embed(source = "../../content/ui/icon-current_move.png")] public static var gfx_CurrentMoveIcon:Class;
		[Embed(source = "../../content/ui/indicator.png")] public static var gfx_Indicator:Class;
		
		[Embed(source = "../../content/ui/range-overlay.png")] public static var gfx_RangeOverlay:Class;
		
		// Tilesets
		[Embed(source = "../../content/tiles/temperate.png")] public static var gfx_TemperateTiles:Class;
		[Embed(source = "../../content/tiles/desert.png")] public static var gfx_DesertTiles:Class;
		[Embed(source = "../../content/tiles/tundra.png")] public static var gfx_TundraTiles:Class;
		
		// Maps
		[Embed(source = "../../content/maps/temperate-1.txt", mimeType = "application/octet-stream")] public static var map_Temperate1:Class;
		[Embed(source = "../../content/maps/tundra-1.txt", mimeType = "application/octet-stream")] public static var map_Tundra1:Class;
		[Embed(source = "../../content/maps/desert-1.txt", mimeType = "application/octet-stream")] public static var map_Desert1:Class;
		
	}

}