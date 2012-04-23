package objects 
{
	import components.BombComponent;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class BombObject extends StationaryObject 
	{
		
		public function BombObject(xPos:int, yPos:int, gfx:Class) 
		{
			super(xPos, yPos, gfx);
			
			this._body.setMaxHealth(25);
			this._body.setHealth(25);
			this._body.setName("Bomb!");
			
			this.addComponent(new BombComponent);
			
		}
		
	}

}