package jaxrtech.spaceshooter
{
	import fl.text.TLFTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.utils.Timer;
	
	import flashx.textLayout.events.TextLayoutEvent;
	import flashx.textLayout.formats.TextLayoutFormat;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.sprites.Bullet;
	import jaxrtech.spaceshooter.sprites.HealthBar;
	import jaxrtech.spaceshooter.sprites.PlayerShip;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	import jaxrtech.spaceshooter.util.DebugUtil;
	import jaxrtech.spaceshooter.util.Util;
	
	public class Game extends BaseUpdatingSprite
	{
		public const ENEMY_SPAWN_DELAY_MS:int = 1000;
		
		private var enemySpawnTimer:Timer = new Timer(ENEMY_SPAWN_DELAY_MS);
		
		public static var bullets:Array = new Array();
		public static var enemies:Array = new Array();
		public static var playerShip:PlayerShip = new PlayerShip();
		
		private var scoreText:TLFTextField;
		private var healthBar:HealthBar;
		
		private var _score:int = 0;
		
		public function Game()
		{
			super();
		}
		
		public override function enable():void
		{
			super.enable();
			
			if (Capabilities.isDebugger)
			{
				DebugUtil.traceStageChildren(stage);
			}
			
			healthBar = stage.getChildByName("healthBar") as HealthBar;
			scoreText = stage.getChildByName("scoreText") as TLFTextField;
			
			addPlayerShip();
			addAndStartSpawnTick();
		}
		
		private function addPlayerShip():void
		{
			playerShip.x = this.stage.stageWidth / 2;
			playerShip.y = this.stage.stageHeight / 2;
			this.stage.addChild(playerShip);
		}
		
		private function addAndStartSpawnTick():void
		{
			enemySpawnTimer.addEventListener(TimerEvent.TIMER, onSpawnTick);
			enemySpawnTimer.start();
		}
		
		public override function disable():void
		{
			super.disable();
			
			removeAllStageChildren();
		}
		
		private function removeAllStageChildren():void
		{
			while (stage.numChildren > 0)
			{
				stage.removeChildAt(0);
			}
		}
		
		protected override function update(e:Event):void
		{
			removeOffStageBullets();
			
			checkEnemyCollisions()
			checkBulletCollisions();
		}
		
		private function removeOffStageBullets():void
		{
			for each (var bullet in bullets)
			{
				if (bullet.x < (0 - bullet.width * 2) && bullet.y < (0 - bullet.height * 2))
				{
					stage.removeChild(bullet);
					var i:int = bullets.indexOf(bullet);
					bullets.splice(i, 1);
				}
			}
		}
		
		private function checkEnemyCollisions():void
		{
			for each (var enemy in enemies)
			{
				if (enemy.hitTestObject(playerShip))
				{
					enemy.destroy();
					Util.removeFromStageAndArray(stage, enemies, enemy);
					playerShip.health -= 10;
					healthBar.health = playerShip.health;
				}
			}
		}
		
		private function checkBulletCollisions():void
		{
			for each (var bullet in bullets)
			{
				for each (var enemy in enemies)
				{
					if (bullet.hitTestObject(enemy))
					{
						enemy.destroy();
						Util.removeFromStageAndArray(stage, enemies, enemy);
						score += 10;
					}
				}
			}
		}
		
		private function onSpawnTick(e:Event):void
		{
			createNewEnemy();
		}
		
		private function createNewEnemy():void
		{
			var enemy:RedEnemy = new RedEnemy();
			enemy.x = Math.random() * stage.stageWidth;
			enemy.y = Math.random() * stage.stageHeight;
			enemies.push(enemy); 
			stage.addChild(enemy);
		}
		
		private function set score(s:int):void
		{
			_score = s;
			scoreText.text = _score.toString();
		}
		
		private function get score():int
		{
			return _score;
		}
		
		/*
		function handleBulletRingBuffer():void
		{
			// Check that we did not go over the limit adding another one
			if (bullets.length > MAX_BULLETS_LIMIT)
			{
				var bullet = bullets[0];
				bullets.splice(0, 1);
				stage.removeChild(bullet);
			}	
		}
		*/
	}
}