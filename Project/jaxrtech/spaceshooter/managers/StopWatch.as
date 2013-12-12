package jaxrtech.spaceshooter.managers
{
	import flash.events.Event;
	import flash.utils.getTimer;
	
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	
	public class StopWatch
	{
		private var time:int;
		private var isEnabled:Boolean = false;
		
		public function start():void
		{
			time = getTimer(); 
			isEnabled = true;
		}
		
		public function get elapsed():int
		{ 
			return (isEnabled) ? (getTimer() - time) : 0;
		}
	}
}