package jaxrtech.spaceshooter.handlers
{
	import jaxrtech.spaceshooter.base.IBaseSprite;
	import jaxrtech.spaceshooter.managers.CollisionManager;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.traits.IProjectile;

	public interface ICollisionHandler
	{
		function get player():IBaseSprite;
		function get enemies():Array;
		function get projectiles():Array;
		
		function onEnemyPlayerCollision(sender:CollisionManager, enemy:IEnemy):void;
		function onBulletEnemyCollision(sender:CollisionManager, bullet:IProjectile, enemy:IEnemy):void;
	}
}