package jaxrtech.spaceshooter.game
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	
	public class SpawnHandlerImpl implements ISpawnHandler
	{
		private var game:Game;
		private var stage:Stage;
		
		private const DELAY_MS:int = 1000;
		
		public function SpawnHandlerImpl(game:Game, stage:Stage)
		{
			this.game = game;
			this.stage = stage;	
		}
		
		public function get delay():int
		{
			return DELAY_MS;
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
			game.enemies.push(enemy); 
			stage.addChild(enemy);
		}
	}
}