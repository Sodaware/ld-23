package objects 
{
	import components.ShootableComponent;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class StationaryObject extends GameObject 
	{
		
		protected var _body:ShootableComponent;
		
		public function StationaryObject(xPos:int, yPos:int, gfx:Class)
		{
			super(xPos, yPos, gfx);
			
			this._body = new ShootableComponent(5);
			this._body.setName("Crate");
			
			this.addComponent(this._body);
		}
		
	}

}