package overlays 
{
	
	import db.ResourceDb;
	import db.ContentDb;
	import org.flixel.FlxButton;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxButtonPlus;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ModalScreenOverlay extends ScreenOverlay 
	{
		
		protected var _title:FlxText;	
		protected var _back:FlxButton;
		protected var _clicked:String;
		
		public function ModalScreenOverlay() 
		{
			super();
			
			this.addBackButton();
		}
		
		protected function addBackButton() : void
		{
			this._back = new FlxButton(4, FlxG.height - 17, null, this.Handle_onBackClick);
			this._back.loadGraphic(ResourceDb.gfx_BackButton, true, false, 33, 13);
			this.add(this._back);
		}
		
		protected function setClicked(name:String) : void
		{
			this._clicked = name;
		}
		
		override public function update():void 
		{
			super.update();
			
			// TODO: Move these to generic fade in / fade out functions
			if (this.isHiding) {
				this._title.alpha -= ContentDb.TRANSITION_SPEED;
				if (this._title.alpha <= 0) {
					this.isHiding = false;
					if (this.onHideFinished != null) this.onHideFinished({button: this._clicked});
				}
			}
			
			if (this.isAppearing) {
				this._title.alpha += ContentDb.TRANSITION_SPEED;
				if (this._title.alpha >= 1) {
					this.isAppearing= false;
					if (this.onShowFinished != null) this.onShowFinished({button: this._clicked});
				}
			}
		}
		
		public function Handle_onBackClick() : void
		{
			this.hide();
			this.setClicked("back");
		}
		
	}

}