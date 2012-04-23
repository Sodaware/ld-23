package objects 
{
	import db.GameObjectDb;
	import components.ShootableComponent;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class Bullet extends GameObject 
	{
		
		private var _parent:GameObject;
		private var _strength:int;
		
		public function Bullet(x:int, y:int, gfx:Class) 
		{
			super(x, y, gfx);
		}
		
		public function setStrength(strength:int) : void
		{
			this._strength = strength;
		}
		
		public function getStrength() : int
		{
			return this._strength;
		}
		
		/**
		 * Set the object wot fired the bullet
		 * @param	parent
		 */
		public function setParent(parent:GameObject) : void
		{
			this._parent = parent;
		}
		
		override public function update():void 
		{
			super.update();
			
			// TODO: Kill after a set time
			
			for each (var obj:GameObject in GameObjectDb.getObjectsWithComponent(ShootableComponent)) {
				if (obj == this._parent) continue;
				
				if (obj.overlaps(this)) {
					
					// TODO: Play sound
					
					// Do some damage
					var body:ShootableComponent = ShootableComponent(obj.getComponent(ShootableComponent))
					body.hitBy(this);
					
					// Destroy
					this.visible = false;
					FlxG.state.remove(this);
					this.destroy();
				}
			}
		}
		
	}

}