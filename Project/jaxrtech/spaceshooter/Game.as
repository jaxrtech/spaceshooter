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
	import jaxrtech.spaceshooter.game.CollisionHandlerImpl;
	import jaxrtech.spaceshooter.game.HealthHandlerImpl;
	import jaxrtech.spaceshooter.game.SpawnHandlerImpl;
	import jaxrtech.spaceshooter.handlers.ICollisionHandler;
	import jaxrtech.spaceshooter.handlers.IHealthHandler;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.managers.CollisionManager;
	import jaxrtech.spaceshooter.managers.HealthManager;
	import jaxrtech.spaceshooter.managers.HealthState;
	import jaxrtech.spaceshooter.managers.SpawnManager;
	import jaxrtech.spaceshooter.sprites.PlayerShip;
	import jaxrtech.spaceshooter.util.DebugUtil;
	import jaxrtech.spaceshooter.util.Util;
	
	public class Game extends BaseUpdatingSprite
	{
		public function Game()
		{
			super();
			// Note: This should only be called once from stage to create the game stage
		}
		
		public var healthManager:HealthManager;
		public var spawnManager:SpawnManager;
		public var collisionManager:CollisionManager;
		
		public var healthHandler:IHealthHandler;
		public var spawnHandler:ISpawnHandler;
		public var collisionHandler:ICollisionHandler;
		
		public var bullets:Array = new Array();
		public var enemies:Array = new Array();
		public var playerShip:PlayerShip = new PlayerShip(this as Game);
		
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
			
			healthHandler = new HealthHandlerImpl(this, stage)
			healthManager = new HealthManager(healthHandler);
			stage.addChild(healthManager);
			
			spawnHandler = new SpawnHandlerImpl(this, stage);
			spawnManager = new SpawnManager(spawnHandler);
			stage.addChild(spawnManager);
			
			collisionHandler = new CollisionHandlerImpl(this, stage);
			collisionManager = new CollisionManager(collisionHandler);
			stage.addChild(collisionManager);
			
			stage.addChild(playerShip);
		}
		
		public override function enable():void
		{
			super.enable();
			
			score = 0;
			spawnManager.enable();
			spawnManager.start();
			healthManager.enable();
			collisionManager.enable();
			configurePlayerShip();
			
			if (Capabilities.isDebugger)
			{
				DebugUtil.traceStageChildren(stage);
			}
		}
		
		public override function disable():void
		{
			super.disable();
			
			playerShip.disable();
			healthManager.disable();
			spawnManager.disable();
			collisionManager.disable();
			
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
			
			if (healthManager.healthState == HealthState.DEAD)
			{
				switchToGameOverMode();
			}
		}
		
		private function configurePlayerShip():void
		{
			playerShip.x = stage.stageWidth / 2;
			playerShip.y = stage.stageHeight / 2;
			playerShip.rotation = 0;
			playerShip.health = healthHandler.maximumHealth;
			playerShip.enable();
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
		
		public function set score(s:int):void
		{
			_score = s;
			scoreText.text = _score.toString();
		}
		
		public function get score():int
		{
			return _score;
		}
	}
}