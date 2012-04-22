package components 
{
	import objects.Bullet;
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ShootableComponent extends BaseComponent 
	{
		private var _health:int;
		private var _maxHealth:int;
		
		
		public function ShootableComponent(maxHealth:int) 
		{
			this._maxHealth = maxHealth;
			this._health = maxHealth;
		}
		
		public function hitBy(bullet:Bullet) : void
		{
			this._health -= bullet.getStrength();
			if (this._health <= 0) {
				this.getParent().kill();
			}
		}
		
	}

}