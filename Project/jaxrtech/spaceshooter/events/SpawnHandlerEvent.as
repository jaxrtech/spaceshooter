package jaxrtech.spaceshooter.events
{
	import flash.events.Event;
	
	public class SpawnHandlerEvent extends Event
	{
		public static const var DELAY_CHANGED
		
		public function SpawnHandlerEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new SpawnHandlerEvent(type, result, bubbles, cancelable);
		}
	}
}