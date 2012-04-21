package components 
{
	import objects.GameObject;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class BaseComponent 
	{
		
		private var _parent:GameObject;
		
		public function attach(obj:GameObject) : void
		{
			this._parent = obj;
			this.afterAttach();
		}
		
		public function BaseComponent() 
		{
			
		}
		
		public function getParent() : GameObject
		{
			return this._parent;
		}
		
		public function afterAttach() : void { }
		public function update() : void { }
		
	}

}