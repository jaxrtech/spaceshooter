package jaxrtech.spaceshooter.game
{
	import flash.display.Stage;
	import flash.events.Event;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	import jaxrtech.spaceshooter.sprites.SpawnHouse;
	
	public class SpawnHandlerHouseImpl implements ISpawnHandler
	{
		private var game:Game;
		private var stage:Stage;
		
		private var house:SpawnHouse;
		
		private const DELAY_MS:int = 1000;
		
		public function SpawnHandlerHouseImpl(game:Game, stage:Stage, house:SpawnHouse)
		{
			this.game = game;
			this.stage = stage;	
			this.house = house;
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
			var enemy:RedEnemy = new RedEnemy(game);
			enemy.x = house.x + (house.width / 2);
			enemy.y = house.y + (house.height / 2);
			game.enemies.push(enemy);
			stage.addChild(enemy);
		}
	}
}