package jaxrtech.spaceshooter.sprites
{
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseServicingSprite;
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.game.SpawnHandlerHouseImpl;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;
	import jaxrtech.spaceshooter.managers.SpawnManager;
	import jaxrtech.spaceshooter.traits.IEnemy;
	
	public class SpawnHouse extends BaseServicingSprite implements IEnemy 
	{
		private var game:Game;
		
		private static const DAMAGE:Number = 20;
		private static const INITIAL_HEALTH:Number = 200;
		private static const POINT_VALUE:Number = 100;
		
		private var _health:Number = INITIAL_HEALTH;
		
		private var spawnHandler:ISpawnHandler;
		private var spawnManager:SpawnManager;
		
		public function SpawnHouse(game:Game)
		{
			super();
			this.game = game;
		}
		
		protected override function config():void
		{
			super.config();
			
			spawnHandler = new SpawnHandlerHouseImpl(game, stage, this);
			spawnManager = new SpawnManager(spawnHandler);
			addStageObject(spawnManager);
		}
		
		public override function enable():void
		{
			super.enable();
			
			spawnManager.start();
		}
		
		public function get damage():Number
		{
			return DAMAGE;
		}
		
		public function get health():Number
		{
			return _health;
		}
		
		public function set health(h:Number):void
		{
			_health = h;
		}
		
		public function get pointValue():Number
		{
			return POINT_VALUE;
		}
	}
}