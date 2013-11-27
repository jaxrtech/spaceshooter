package jaxrtech.spaceshooter.managers
{
	import flash.system.Capabilities;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.handlers.IHealthHandler;
	
	public class HealthManager extends BaseSprite
	{
		public static const MAXIMUM_HEALTH:int = 100;
		public static const MINIMUM_HEALTH:int = 0;
		
		public var healthState:int = HealthState.INVALID;
		
		private var INITIAL_BAR_WIDTH:int;
		
		private var handler:IHealthHandler;
		private var _health:int = MAXIMUM_HEALTH;
		
		public function HealthManager(handler:IHealthHandler)
		{
			super();
			
			this.handler = handler;
		}
		
		public override function enable():void
		{
			super.enable();
			
			INITIAL_BAR_WIDTH = Game.INSTANCE.healthBar.width;
			healthState = HealthState.ALIVE;
		}
		
		public override function disable():void
		{
			super.disable();
			
			healthState = HealthState.INVALID;
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
			
			Game.INSTANCE.healthText.text = _health.toString();
			Game.INSTANCE.healthBar.width = (_health * INITIAL_BAR_WIDTH) / 100.0;
			
			if (Capabilities.isDebugger)
			{
				trace("Player HP: " + _health);
			}
			
			if (_health <= MINIMUM_HEALTH && healthState != HealthState.DEAD)
			{
				healthState = HealthState.DYING;
				handler.onDeath();
			}
		}
	}
}