package jaxrtech.spaceshooter.sprites
{
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.util.Targetting;
	
	public class RedEnemy extends BaseUpdatingSprite implements IEnemy
	{
		private static const SPEED:int = 3;
		private static const INITAL_HEALTH:int = 10;
		private static const DAMAGE:int = 10;
		private static const POINT_VALUE:int = 10;
		
		private static const ROTATION_SPEED:int = 10;
		
		private var _health = INITAL_HEALTH;
		
		public function RedEnemy()
		{
			super();
		}
		
		public override function update(e:Event):void
		{
			// Rotation animation
			rotation += ROTATION_SPEED;
			
			Targetting.moveObjectTowardTargetAtDelta(this, Game.INSTANCE.playerShip, SPEED);
		}
		
		public function get health():int
		{
			return _health;
		}
		
		public function set health(h:int):void
		{
			_health = h;
		}
		
		public function get pointValue():int
		{
			return POINT_VALUE;
		}
		
		public function get damage():int
		{
			return DAMAGE;
		}
	}
}