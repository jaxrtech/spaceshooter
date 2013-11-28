package jaxrtech.spaceshooter.managers
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.handlers.ICollisionHandler;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.traits.IProjectile;

	public class CollisionManager extends BaseUpdatingSprite
	{
		private var handler:ICollisionHandler;
		
		public function CollisionManager(handler:ICollisionHandler)
		{
			super();
			this.handler = handler;
		}
		
		public override function update(e:Event):void
		{
			checkBulletCollisions();
			checkEnemyCollisions();
		}
		
		private function checkEnemyCollisions():void
		{
			for each (var enemy:IEnemy in Game.INSTANCE.enemies)
			{
				if ((enemy as DisplayObject).hitTestObject(Game.INSTANCE.playerShip as DisplayObject))
				{
					handler.onEnemyPlayerCollision(this, enemy);
				}
			}
		}
		
		private function checkBulletCollisions():void
		{
			for each (var bullet:IProjectile in Game.INSTANCE.bullets)
			{
				for each (var enemy:IEnemy in Game.INSTANCE.enemies)
				{
					if ((bullet as DisplayObject).hitTestObject(enemy as DisplayObject))
					{
						handler.onBulletEnemyCollision(this, bullet, enemy);
					}
				}
			}
		}
	}
}