package jaxrtech.spaceshooter.managers
{
	import flash.events.*;
	import flash.utils.Timer;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.sprites.RedEnemy;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;

	public class SpawnManager extends BaseSprite
	{
		private const DELAY_MS:int = 1000;
		private var timer:Timer = new Timer(DELAY_MS);
		private var handler:ISpawnHandler;
		
		public function SpawnManager(handler:ISpawnHandler)
		{
			super();
			
			this.handler = handler;
			timer.addEventListener(TimerEvent.TIMER, handler.onSpawnTick);
		}
		
		public override function enable():void
		{
			super.enable();
			this.start();
		}
		
		public override function disable():void
		{
			super.disable();
			timer.stop();
		}
		
		public function start():void
		{
			timer.start();
		}
		
		public function stop():void
		{
			timer.stop();
		}
	}
}