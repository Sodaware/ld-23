package objects 
{
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class InventoryItem 
	{
		
		private var _name:String;
		private var _icon:Class;
		
		
		// ----------------------------------------------------------------------
		// -- Public Properties
		// ----------------------------------------------------------------------
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get icon():Class 
		{
			return _icon;
		}
		
		public function InventoryItem(name:String, icon:Class = null) 
		{
			this._name = name;
			this._icon = icon;
		}
		
		// Various event handlers
		public function onAdd() : void 		{ }
		public function onRemove() : void 	{ }
		public function onUse() : void 		{ }
		public function onDrop() : void		{ }
		
	}

}