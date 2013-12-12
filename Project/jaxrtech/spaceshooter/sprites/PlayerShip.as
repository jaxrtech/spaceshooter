package jaxrtech.spaceshooter.sprites
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	import jaxrtech.spaceshooter.handlers.IMouseHandler;
	import jaxrtech.spaceshooter.managers.KeyboardManager;
	import jaxrtech.spaceshooter.managers.MouseFollower;
	import jaxrtech.spaceshooter.managers.MouseManager;
	import jaxrtech.spaceshooter.traits.IKillable;
	
	public class PlayerShip extends BaseUpdaingSprite implements IMouseHandler, IKillable
	{
		private var game:Game;
		
		private static const SPEED:Number = 5;
		private static const SHOOT_WAIT_MS:int = 50;
		
		private static const UP_KEY:uint = Keyboard.W;
		private static const DOWN_KEY:uint = Keyboard.S;
		private static const LEFT_KEY:uint = Keyboard.A;
		private static const RIGHT_KEY:uint = Keyboard.D;
		
		private var keys:Array = [UP_KEY, DOWN_KEY, LEFT_KEY, RIGHT_KEY]
		private var keyboardManager:KeyboardManager = new KeyboardManager(keys);
		
		private var shipMouseFollower:MouseFollower = new MouseFollower(this as Sprite);
		private var mouseHandler:MouseManager = new MouseManager(this as IMouseHandler);
		
		private var shootTimer:Timer = new Timer(SHOOT_WAIT_MS);
		
		private var _health:Number = 100;
			
		public function PlayerShip(game:Game)
		{
			super();
			this.game = game;
		}
		
		protected override function config():void
		{
			addStageObject(keyboardManager);
			addStageObject(shipMouseFollower);
			addStageObject(mouseHandler);
		}
		
		public override function enable():void
		{
			super.enable();
			
			shootTimer.start();
		}
		
		public override function disable():void
		{
			super.disable();
			
			shootTimer.stop();
		}
		
		public override function update(e:Event):void
		{
			handlePositionKeypresses();
		}
		
		private function handlePositionKeypresses():void
		{
			if (keyboardManager.isKeyDown(UP_KEY))
			{
				this.y -= SPEED;
			}
			if (keyboardManager.isKeyDown(DOWN_KEY))
			{
				this.y += SPEED;
			}
			if (keyboardManager.isKeyDown(LEFT_KEY))
			{
				this.x -= SPEED; 
			}
			if (keyboardManager.isKeyDown(RIGHT_KEY))
			{
				this.x += SPEED;
			}
		}
		
		public function onBeginDrag(e:MouseEvent):void
		{
			shootTimer.addEventListener(TimerEvent.TIMER, shoot);
			shootTimer.start();
		}
		
		public function onDrag(e:MouseEvent):void { }
		
		public function onEndDrag(e:Event):void
		{
			shootTimer.stop();
			shootTimer.removeEventListener(TimerEvent.TIMER, shoot);
		}
		
		private function shoot(e:TimerEvent):void
		{
			var bullet = new Bullet();
			bullet.x = this.x;
			bullet.y = this.y;
			bullet.rotation = this.shipMouseFollower.generatedRotation;
			
			stage.addChildAt(bullet, 0);
			game.bullets.push(bullet);
		}
		
		public function get health():Number
		{
			return _health;
		}
		
		public function set health(h:Number):void
		{
			_health = h;
			
			game.healthManager.health = _health;
		}
	}
}