package jaxrtech.spaceshooter.game
{
	import flash.display.Stage;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.base.IService;
	import jaxrtech.spaceshooter.handlers.ICollisionHandler;
	import jaxrtech.spaceshooter.managers.CollisionManager;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.traits.IProjectile;
	import jaxrtech.spaceshooter.util.Util;
	
	public class CollisionHandlerImpl implements ICollisionHandler
	{
		private var stage:Stage;
		private var game:Game;
		
		public function CollisionHandlerImpl(game:Game, stage:Stage)
		{
			this.game = game;
			this.stage = stage;
		}
		
		public function get player():IService
		{
			return game.playerShip;
		}
		
		public function get enemies():Array
		{
			return game.enemies;
		}
		
		public function get projectiles():Array
		{
			return game.bullets;
		}
		
		public function onEnemyPlayerCollision(sender:CollisionManager, enemy:IEnemy):void
		{
			game.playerShip.health -= enemy.damage;
			
			Util.removeFromArrayAndStage(stage, game.enemies, enemy as BaseSprite);
		}
		
		public function onBulletEnemyCollision(sender:CollisionManager, bullet:IProjectile, 
											   enemy:IEnemy):void
		{
			enemy.health -= bullet.damage;
			Util.removeFromArrayAndStage(stage, game.bullets, bullet as BaseSprite);
			
			if (enemy.health <= 0)
			{
				Util.removeFromArrayAndStage(stage, game.enemies, enemy as BaseSprite);
				game.score += enemy.pointValue;
			}
		}
	}
}