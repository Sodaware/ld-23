package util.actions 
{
	import components.ScannableComponent;
	import db.ResourceDb;
	import db.SessionDb;
	import objects.AnimalObject;
	import objects.Bullet;
	import objects.GameObject;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSave;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxU;
	import org.flixel.plugin.photonstorm.FlxDelay;
	import util.EntityAction;
	
	/**
	 * ...
	 * @author Phil Newton
	 */
	public class ScanObjectAction extends EntityAction
	{
		private var _delay:FlxDelay;
		private var _text:FlxText;
		private var _chance:Number;
		private var _result:Number;
		private var _scanDelay:FlxDelay;
		
		public function ScanObjectAction(eventType:int, args:Object)
		{
			super(eventType, args);
		}
		
		public override function update() : void
		{
			if (this._delay && this._delay.hasExpired) {
				this.setFinished(true);
				FlxG.state.remove(this._text);
			}
			
			if (this._scanDelay) {
				if (this._scanDelay.hasExpired) {
					var result:String = (this._result > this._chance) ? "CAPTURED" : "FAILURE";
					this._text.text = this._result + " > " + this._chance + "\n" + result;
					this._scanDelay = null;
					
					if (this._result > this._chance) {
						var target:AnimalObject = this.getArg("target") as AnimalObject;
						SessionDb.bestiaryStatus[target.name] = true;
					}
				
				} else {
					this._text.text = Math.round(Math.random() * 100) + " > " + this._chance ;
				}
			}
			 
			
			
		}
		
		public override function execute() : void
		{
			this._delay = new FlxDelay(1500);
			this._delay.start();

			this._scanDelay = new FlxDelay(750);
			this._scanDelay = new FlxDelay(750);
			this._scanDelay.start();

			this._text = new FlxText(0, 4, 160, "--- > ---");
			this._text.alignment = "center";
			FlxG.state.add(this._text);
			
			// Calculate target position
			var target:GameObject = GameObject(this.getArg("target"));
			if (!target) {
				return;
			}
			
			// Calculate distance
			var distance:Number = FlxU.getDistance(new FlxPoint(this._entity.x, this._entity.y), new FlxPoint(target.x, target.y));
			
			// Calculate chance
			var scannable:ScannableComponent = target.getComponent(ScannableComponent) as ScannableComponent;
			this._chance 	= Math.round(100 * (1 / Number((distance / 16) * scannable.getDifficulty())));
			this._result	= Math.round(100 * (Math.random()));
			FlxG.play(ResourceDb.snd_Shoot1);
			
		}
		
	}

}