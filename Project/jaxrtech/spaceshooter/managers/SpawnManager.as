package jaxrtech.spaceshooter.managers
{
	import flash.events.*;
	import flash.utils.Timer;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	import jaxrtech.spaceshooter.handlers.ISpawnHandler;

	public class SpawnManager extends BaseSprite
	{
		private var ticks:Number = 0;
		private var lastFiringTick:Number = 0;
		private var timer:Timer;
		private var handler:ISpawnHandler;
		
		public function SpawnManager(handler:ISpawnHandler)
		{
			super();
			
			this.handler = handler;
			timer = new Timer(handler.delay);
			timer.addEventListener(TimerEvent.TIMER, handler.onSpawnTick);
		}
		
		public override function enable():void
		{
			super.enable();
			start();
		}
		
		public override function disable():void
		{
			super.disable();
			stop();
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