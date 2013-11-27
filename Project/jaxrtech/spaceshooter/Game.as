package jaxrtech.spaceshooter
{
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.base.IBaseSprite;
	import jaxrtech.spaceshooter.handlers.IHealthHandler;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.managers.HealthManager;
	import jaxrtech.spaceshooter.managers.HealthState;
	import jaxrtech.spaceshooter.managers.SpawnManager;
	import jaxrtech.spaceshooter.sprites.PlayerShip;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	import jaxrtech.spaceshooter.traits.IEnemy;
	import jaxrtech.spaceshooter.util.DebugUtil;
	import jaxrtech.spaceshooter.util.Util;
	
	public class Game extends BaseUpdatingSprite implements IHealthHandler, ISpawnHandler
	{
		public static var INSTANCE:Game;
		
		public function Game()
		{
			super();
		}
		
		public var healthManager:HealthManager;
		public var spawnManager:SpawnManager;
		
		public var bullets:Array = new Array();
		public var enemies:Array = new Array();
		public var playerShip:PlayerShip = new PlayerShip();
		
		public var scoreText:TLFTextField;
		public var healthBar:MovieClip;
		public var healthText:TLFTextField;
		
		public var overlay:MovieClip;
		public var gameOver:TLFTextField;
		public var replayButton:SimpleButton;
		
		private var _score:int = 0;
		
		public override function init():void
		{
			super.init();
			
			scoreText = stage.getChildByName("scoreText") as TLFTextField;
			healthBar = stage.getChildByName("healthBar") as MovieClip;
			healthText = stage.getChildByName("healthText") as TLFTextField;
			
			overlay = stage.getChildByName("overlay") as MovieClip;
			overlay.visible = false;
			gameOver = stage.getChildByName("gameOver") as TLFTextField;
			gameOver.visible = false;		
			replayButton = stage.getChildByName("replayButton") as SimpleButton;
			replayButton.visible = false;
			
			healthManager = new HealthManager(this as IHealthHandler);
			spawnManager = new SpawnManager(this as ISpawnHandler);
			stage.addChild(healthManager);
			stage.addChild(spawnManager);
			
			stage.addChild(playerShip);
		}
		
		public override function enable():void
		{
			super.enable();
			
			configurePlayerShip();
			spawnManager.enable();
			spawnManager.start();
			healthManager.enable();
			
			if (Capabilities.isDebugger)
			{
				DebugUtil.traceStageChildren(stage);
			}
		}
		
		private function configurePlayerShip():void
		{
			playerShip.x = stage.stageWidth / 2;
			playerShip.y = stage.stageHeight / 2;
			playerShip.rotation = 0;
			playerShip.health = HealthManager.MAXIMUM_HEALTH;
			playerShip.enable();
		}
		
		public override function disable():void
		{
			super.disable();
			
			playerShip.disable();
			healthManager.disable();
			spawnManager.disable();
			
			Util.applyToArray(enemies, function(enemy:IBaseSprite):void 
			{
				enemy.disable();
			});
			Util.applyToArray(bullets, function(bullet:IBaseSprite):void
			{
				bullet.disable();
			});
		}
		
		public override function update(e:Event):void
		{
			removeOffStageBullets();
			
			checkEnemyCollisions()
			checkBulletCollisions();
			
			if (healthManager.healthState == HealthState.DEAD)
			{
				switchToGameOverMode();
			}
		}
		
		private function removeOffStageBullets():void
		{
			for each (var bullet:DisplayObject in bullets)
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
			for each (var enemy:IEnemy in enemies)
			{
				if ((enemy as DisplayObject).hitTestObject(playerShip))
				{
					playerShip.health -= enemy.damage;
					
					enemy.destroy();
					Util.removeFromArrayAndStage(stage, enemies, enemy as IBaseSprite);
				}
			}
		}
		
		private function checkBulletCollisions():void
		{
			for each (var bullet in bullets)
			{
				for each (var enemy:IEnemy in enemies)
				{
					if (bullet.hitTestObject(enemy))
					{
						enemy.health -= bullet.damage;
						
						if (enemy.health <= 0)
						{
							enemy.destroy();
							Util.removeFromArrayAndStage(stage, enemies, enemy as IBaseSprite);
							score += enemy.pointValue;
						}
					}
				}
			}
		}
		
		public function onSpawnTick(e:Event):void
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
		
		public function onDeath():void
		{
			trace("onDeath() called");
			healthManager.healthState = HealthState.DEAD;
		}
		
		private function switchToGameOverMode():void
		{
			this.disable();
			
			overlay.visible = true;
			gameOver.visible = true;
			replayButton.visible = true;
			replayButton.addEventListener(MouseEvent.CLICK, onReplay);
		}
		
		private function onReplay(e:MouseEvent):void
		{
			replayButton.removeEventListener(MouseEvent.CLICK, onReplay);
			overlay.visible = false;
			gameOver.visible = false;
			replayButton.visible = false;
			
			Util.removeAllFromArrayAndStage(stage, bullets);
			Util.removeAllFromArrayAndStage(stage, enemies);
			
			this.enable();
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
	}
}