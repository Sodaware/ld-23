package ui 
{
	import org.flixel.FlxButton;
	import org.flixel.FlxText;
	import db.ResourceDb;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class MovementButton extends FlxButton
	{
		
		private var _label:FlxText;
		private var _text:String;
		
		public function MovementButton(x:int, y:int, imageClass:Class, onClick:Function, helpLabel:FlxText, helpText:String) 
		{
			super(x, y, null, onClick);
			
			this._label = helpLabel;
			this._text	= helpText;
			
			this.loadGraphic(imageClass, true, false, 16, 16);
			this.onOver = this.Handle_onOver;
			this.onOut	= this.Handle_onOut;
		
		}
		
		private function Handle_onOver() : void
		{
			this._label.text = this._text;
		}
		
		private function Handle_onOut() : void
		{
			this._label.text = "";
		}

		
	}

}