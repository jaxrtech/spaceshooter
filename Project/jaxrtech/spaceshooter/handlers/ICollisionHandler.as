package jaxrtech.spaceshooter.handlers
{
	import jaxrtech.spaceshooter.managers.CollisionManager;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.traits.IProjectile;

	public interface ICollisionHandler
	{
		function onEnemyPlayerCollision(sender:CollisionManager, enemy:IEnemy):void;
		function onBulletEnemyCollision(sender:CollisionManager, bullet:IProjectile, enemy:IEnemy):void;
	}
}