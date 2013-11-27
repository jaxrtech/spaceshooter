package jaxrtech.spaceshooter.sprites
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.handlers.IMouseHandler;
	import jaxrtech.spaceshooter.managers.KeyboardManager;
	import jaxrtech.spaceshooter.managers.MouseFollower;
	import jaxrtech.spaceshooter.managers.MouseManager;
	import jaxrtech.spaceshooter.traits.IKillable;
	
	public class PlayerShip extends BaseUpdatingSprite implements IMouseHandler, IKillable
	{
		private static const SPEED:int = 5;
		private static const SHOOT_WAIT_MS:int = 100;
		
		private static const UP_KEY:uint = Keyboard.W;
		private static const DOWN_KEY:uint = Keyboard.D;
		private static const LEFT_KEY:uint = Keyboard.A;
		private static const RIGHT_KEY:uint = Keyboard.D;
		
		private var keys:Array = [UP_KEY, DOWN_KEY, LEFT_KEY, RIGHT_KEY]
		private var keyboardManager:KeyboardManager = new KeyboardManager(keys);
		
		private var shipMouseFollower:MouseFollower = new MouseFollower(this as Sprite);
		private var mouseHandler:MouseManager = new MouseManager(this as IMouseHandler);
		
		private var shootTimer:Timer = new Timer(SHOOT_WAIT_MS);
		
		private var _health:int = 100;
			
		public function PlayerShip()
		{
			super();
		}
		
		public override function init():void
		{
			super.init();
			
			stage.addChild(keyboardManager);
			stage.addChild(shipMouseFollower);
			stage.addChild(mouseHandler);
		}
		
		public override function enable():void
		{
			super.enable();
			
			keyboardManager.enable();
			shipMouseFollower.enable();
			mouseHandler.enable();
			shootTimer.start();
		}
		
		public override function disable():void
		{
			super.disable();
			
			shootTimer.stop();
			keyboardManager.disable();
			shipMouseFollower.disable();
			mouseHandler.disable();
		}
		
		public override function destroy():void
		{
			super.destroy();
			
			stage.removeChild(keyboardManager);
			stage.removeChild(shipMouseFollower);
			stage.removeChild(mouseHandler);
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
			Game.INSTANCE.bullets.push(bullet);
		}
		
		public function get health():int
		{
			return _health;
		}
		
		public function set health(h:int):void
		{
			_health = h;
			
			Game.INSTANCE.healthManager.health = _health;
		}
	}
}