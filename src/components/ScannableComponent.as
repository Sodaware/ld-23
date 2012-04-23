package components 
{
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ScannableComponent extends BaseComponent 
	{
		
		private var _difficulty:int;
		
		public function ScannableComponent(difficulty:int) 
		{
			this._difficulty = difficulty;
		}
		
		public function getDifficulty() : int
		{
			return this._difficulty;
		}
		
	}

}