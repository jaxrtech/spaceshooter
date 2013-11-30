package jaxrtech.spaceshooter.sprites
{
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.util.Targetting;
	
	public class RedEnemy extends BaseUpdaingSprite implements IEnemy
	{
		private var game:Game;
		
		private static const SPEED:Number = 3;
		private static const INITAL_HEALTH:Number = 10;
		private static const DAMAGE:Number = 10;
		private static const POINT_VALUE:Number = 10;
		
		private static const ROTATION_SPEED:Number = 10;
		
		private var _health = INITAL_HEALTH;
		
		public function RedEnemy(game:Game)
		{
			super();
			this.game = game;
		}
		
		public override function update(e:Event):void
		{
			// Rotation animation
			rotation += ROTATION_SPEED;
			
			Targetting.moveObjectTowardTargetAtDelta(this, game.playerShip, SPEED);
		}
		
		public function get health():Number
		{
			return _health;
		}
		
		public function set health(h:Number):void
		{
			_health = h;
		}
		
		public function get pointValue():Number
		{
			return POINT_VALUE;
		}
		
		public function get damage():Number
		{
			return DAMAGE;
		}
	}
}