package jaxrtech.spaceshooter.managers
{
	import flash.system.Capabilities;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.handlers.IHealthHandler;
	
	public class HealthManager extends BaseSprite
	{	
		public var healthState:int = HealthState.INVALID;
		
		private var handler:IHealthHandler;
		private var _health:int;
		
		public function HealthManager(handler:IHealthHandler)
		{
			super();
			this.handler = handler;
			_health = handler.maximumHealth;
		}
		
		public override function enable():void
		{
			super.enable();
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
			if (h > handler.maximumHealth) h = handler.maximumHealth;
			if (h < handler.minimumHealth) h = handler.minimumHealth;
			_health = h;
			handler.onHealthChange(this, _health);
			
			if (Capabilities.isDebugger)
			{
				trace("Player HP: " + _health);
			}
			
			if (_health <= handler.minimumHealth && healthState != HealthState.DEAD)
			{
				healthState = HealthState.DYING;
				handler.onStateChange(this, healthState);
			}
		}
	}
}