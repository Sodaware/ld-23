package objects 
{
	import components.InventoryComponent;
	import db.ResourceDb;
	/**
	 * Just a simple crate. Like a standard stationary object, but has an inventory
	 * that can contain an optional item.
	 * @author Phil Newton
	 */
	public class CrateObject extends StationaryObject 
	{
		
		private var _inventory:InventoryComponent;
		
		public function CrateObject(xPos:int, yPos:int, gfx:Class) 
		{
			super(xPos, yPos, gfx);
			
			this._inventory = new InventoryComponent();
		
			// Add something or other
			this._inventory.addItem(new EvilRobotObject(this.x, this.y, ResourceDb.gfx_EvilRobot));
			
			this.addComponent(this._inventory);
		}
		
	}

}