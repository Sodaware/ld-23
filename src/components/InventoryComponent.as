package components 
{
	import db.GameObjectDb;
	import events.DamageEvent;
	import events.GameEventDispatcher;
	import objects.GameObject;
	import org.flixel.FlxG;
	
	/**
	 * An inventory contains usable items.
	 * 
	 * @author Phil Newton
	 */
	public class InventoryComponent extends BaseComponent
	{
		
		private var _items:Array;
		
		public function InventoryComponent() 
		{
			// Init
			this._items = [];
			
			// Hook up to destroyed event
			GameEventDispatcher.getInstance().addEventListener(GameEventDispatcher.EVENT_DAMAGE, this.Handle_onParentDamaged);
		}
		
		// TODO: Should probably change this to a non-game object (as 99% of inventory items don't need to be rendered)
		public function addItem(item:GameObject) : void
		{
			// Deactivate the item (so it doesn't do anything unexpected)
			item.active = false;
			
			this._items.push(item);
		}
		
		protected function Handle_onParentDamaged(e:DamageEvent) : void
		{
			if (e.getEntity() != this.getParent()) return;
			if (!e.isFatal()) return;
			if (!this._items.length) return;
			
			// Add all items to the world
			for each(var o:GameObject in this._items) {
				o.active = true;
				GameObjectDb.add(o);
			}
		}
		
	}

}