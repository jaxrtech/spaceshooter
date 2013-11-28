package jaxrtech.spaceshooter.game
{
	import jaxrtech.spaceshooter.handlers.IHealthHandler;
	import jaxrtech.spaceshooter.managers.HealthManager;
	import jaxrtech.spaceshooter.managers.HealthState;
	import flash.display.Stage;
	import jaxrtech.spaceshooter.Game;
	
	public class HealthHandlerImpl implements IHealthHandler
	{ 
		private static const MAXIMUM_HEALTH:int = 100;
		private static const MINIMUM_HEALTH:int = 0;
		
		private var game:Game;
		private var stage:Stage;
		private var INITIAL_BAR_WIDTH:Number;
		
		public function HealthHandlerImpl(game:Game, stage:Stage)
		{
			this.game = game;
			this.stage = stage;
			
			INITIAL_BAR_WIDTH = game.healthBar.width;
		}
		
		public function get minimumHealth():Number
		{
			return MINIMUM_HEALTH;
		}
		
		public function get maximumHealth():Number
		{
			return MAXIMUM_HEALTH;
		}
		
		public function onStateChange(sender:HealthManager, state:uint):void
		{
			if (state == HealthState.DYING)
			{
				sender.healthState = HealthState.DEAD;
			}
		}
		
		public function onHealthChange(sender:HealthManager, health:Number):void
		{
			game.healthText.text = health.toString();
			game.healthBar.width = (health * INITIAL_BAR_WIDTH) / 100.0;
		}
	}
}