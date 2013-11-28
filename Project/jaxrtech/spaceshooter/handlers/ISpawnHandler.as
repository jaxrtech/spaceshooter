package jaxrtech.spaceshooter.handlers
{
	import flash.events.Event;

	public interface ISpawnHandler
	{
		function get delay():int;
		function onSpawnTick(e:Event):void;
	}
}