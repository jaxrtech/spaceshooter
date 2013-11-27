package jaxrtech.spaceshooter.sprites
{
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.system.Capabilities;
	import flash.text.TextField;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	
	public class HealthBar extends BaseSprite
	{
		private static const MAXIMUM_HEALTH = 100;
		private static const MINIMUM_HEALTH = 0;
		
		private var INITIAL_BAR_WIDTH:int;
		private var healthBar:MovieClip;
		private var healthText:TLFTextField;
		
		private var _health:int = MAXIMUM_HEALTH;
		
		public function HealthBar()
		{
			super();
		}
		
		public override function enable():void
		{
			super.enable();
			
			healthBar = stage.getChildByName("healthBar") as MovieClip;
			healthText = stage.getChildByName("healthText") as TLFTextField;
			
			INITIAL_BAR_WIDTH = healthBar.width;
		}
		
		public function get health():int
		{
			return _health;
		}
		
		public function set health(h:int):void
		{
			if (h < MINIMUM_HEALTH) h = MINIMUM_HEALTH;
			if (h > MAXIMUM_HEALTH) h = MAXIMUM_HEALTH;
			_health = h;
			
			healthText.text = _health.toString();
			healthBar.width = (_health * INITIAL_BAR_WIDTH) / 100.0;
			
			if (Capabilities.isDebugger)
			{
				trace("Player HP: " + _health);
			}
		}
	}
}