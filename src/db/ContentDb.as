package db
{
	
	public class ContentDb
	{
		
		public static const ACTION_MOVE_FORWARD:int = 1;
		public static const ACTION_MOVE_LEFT:int = 2;
		public static const ACTION_MOVE_RIGHT:int = 3;
		public static const ACTION_MOVE_BACK:int = 4;

		public static const ACTION_TURN_LEFT:int = 5;
		public static const ACTION_TURN_RIGHT:int = 6;
		
		public static const ACTION_SHOOT:int = 7;
		public static const ACTION_USE_ITEM:int = 8;
		public static const ACTION_SCAN:int = 9;
		
		public static const ACTION_DO_NOTHING:int = 10;
		
		// 0.025
		public static const TRANSITION_SPEED:Number = 1.0;
		
		// Data
		public static var animalData:Object = {
			
			bushman: {
				name:	"BushMan",
				habitat: "Temperate",
				sprite: ResourceDb.gfx_AnimalBushman,
				description: "Bushmen are covered in barbed spines that they eject when threatened.\n\nThey are found on many planets in the galaxy.",
				difficulty: 1
			},
			
			space_bear: {
				name:	"Space Bear",
				habitat: "Tundra",
				sprite: ResourceDb.gfx_AnimalSpaceBear,
				description: "Space bears can hibernate for up to 1000 years.\n\nAfter emerging from hibernation, they will hunt for picnic baskets.",
				difficulty: 2
			},
			
			space_snake: {
				name:	"Space Snake",
				habitat: "Desert",
				sprite: ResourceDb.gfx_AnimalSpaceSnake,
				description: "Space snakes can dislocate their jaw to eat larger prey.\n\nTheir favourite food is space bears.",
				difficulty: 3
			}
			
			
			
			
		};
		
		
		
	}
}