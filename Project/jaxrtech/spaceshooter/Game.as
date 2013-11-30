package jaxrtech.spaceshooter
{
	import fl.text.TLFTextField;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	import jaxrtech.spaceshooter.base.IService;
	import jaxrtech.spaceshooter.game.CollisionHandlerImpl;
	import jaxrtech.spaceshooter.game.HealthHandlerImpl;
	import jaxrtech.spaceshooter.game.SpawnHandlerGameImpl;
	import jaxrtech.spaceshooter.game.SpawnHandlerHouseImpl;
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
	
	public class Game extends BaseUpdaingSprite
	{
		public function Game()
		{
			super();
			// Note: This should only be called once from stage to create the game stage
		}
		
		public var healthHandler:IHealthHandler;
		public var healthManager:HealthManager;
		
		public var collisionHandler:ICollisionHandler;
		public var collisionManager:CollisionManager;
		
		public var spawnHandler:ISpawnHandler;
		public var spawnManager:SpawnManager;
		
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
		
		protected override function config():void
		{
			scoreText = stage.getChildByName("scoreText") as TLFTextField;
			healthBar = stage.getChildByName("healthBar") as MovieClip;
			healthText = stage.getChildByName("healthText") as TLFTextField;
			
			overlay = stage.getChildByName("overlay") as MovieClip;
			gameOver = stage.getChildByName("gameOver") as TLFTextField;
			replayButton = stage.getChildByName("replayButton") as SimpleButton;
			
			healthHandler = new HealthHandlerImpl(this, stage);
			healthManager = new HealthManager(healthHandler);
			addStageObject(healthManager);
			
			collisionHandler = new CollisionHandlerImpl(this, stage);
			collisionManager = new CollisionManager(collisionHandler);
			addStageObject(collisionManager);
			
			spawnHandler = new SpawnHandlerGameImpl(this, stage);
			spawnManager = new SpawnManager(spawnHandler);
			addStageObject(spawnManager);
			
			addStageObject(playerShip);
			addServiceArray(bullets);
			addServiceArray(enemies);
		}
		
		public override function init():void
		{
			super.init();
			
			overlay.visible = false;
			gameOver.visible = false;		
			replayButton.visible = false;
		}
		
		public override function enable():void
		{
			super.enable();
			
			score = 0;
			configurePlayerShip();
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