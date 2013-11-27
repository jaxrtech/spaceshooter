package jaxrtech.spaceshooter.sprites
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.helpers.MouseFollower;
	
	public class RedEnemy extends BaseUpdatingSprite
	{
		private static const SPEED:int = 3;
		
		public function RedEnemy()
		{
			super();
		}
		
		protected override function update(e:Event):void
		{
			// Rotation animation
			rotation += 10;
			
			MouseFollower.moveObjectTowardTargetAtDelta(this, Game.playerShip, SPEED);
		}
	}
}