package db 
{
	
	public class SessionDb 
	{
		
		// Bestiary stuff
		public static var bestiaryStatus:Object = {
			bushman: 		false,
			space_bear: 	false,
			space_snake:	false
		};
		
		
		
		public static var QueueSize:int = 4;
		
		public static var playerStats:Object = {
			scanner_strength: 	2,
			weapon_strength:  	5,
			armour_strength:    0,
			action_slots:		4,
			max_health:			20
		};
		
	}

}