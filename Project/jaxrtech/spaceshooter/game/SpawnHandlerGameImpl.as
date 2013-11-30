package jaxrtech.spaceshooter.game
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	import jaxrtech.spaceshooter.sprites.SpawnHouse;
	
	public class SpawnHandlerGameImpl implements ISpawnHandler
	{
		private var game:Game;
		private var stage:Stage;
		
		private const DELAY_MS:int = 3000;
		
		public function SpawnHandlerGameImpl(game:Game, stage:Stage)
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
			createNewSpawnHouse();
		}
		
		private function createNewSpawnHouse():void
		{
			var spawnHouse:SpawnHouse = new SpawnHouse(game);
			spawnHouse.x = Math.random() * stage.stageWidth;
			spawnHouse.y = Math.random() * stage.stageHeight;
			game.enemies.push(spawnHouse);
			stage.addChild(spawnHouse);
		}
	}
}