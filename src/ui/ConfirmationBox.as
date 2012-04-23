package ui 
{
	import overlays.ModalScreenOverlay;
	import org.flixel.FlxText;
	import org.flixel.FlxSprite;
	
	import db.ResourceDb;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ConfirmationBox extends ModalScreenOverlay 
	{
		
		private var _bg:FlxSprite;
		private var _info:FlxText;
		
		private var onClose:Function;
		
		public function ConfirmationBox(message:String, onCloseHandler:Function) 
		{
			this._bg = new FlxSprite(4, 24, ResourceDb.gfx_BeastiaryWindow);
			this.add(this._bg);
			
			this._info = new FlxText(8, 16, 100, message);
			this.add(this._info);
			
			this.addBackButton();
			this.onClose = onCloseHandler;
			
			this._back.x += 6; this._back.y -= 6;
		}
		
		override public function Handle_onBackClick() : void
		{
			this.onClose();
		}
		
	}

}