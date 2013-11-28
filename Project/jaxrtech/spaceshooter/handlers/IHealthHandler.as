package jaxrtech.spaceshooter.handlers
{
	import jaxrtech.spaceshooter.managers.HealthManager;

	public interface IHealthHandler
	{
		function get minimumHealth():Number;
		function get maximumHealth():Number;
		function onStateChange(sender:HealthManager, state:uint):void;
		function onHealthChange(sender:HealthManager, health:Number):void;
	}
}