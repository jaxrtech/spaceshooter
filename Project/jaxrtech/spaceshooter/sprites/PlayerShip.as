package jaxrtech.spaceshooter.sprites
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import jaxrtech.spaceshooter.Game;
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.helpers.IMouseHandler;
	import jaxrtech.spaceshooter.helpers.KeyboardManager;
	import jaxrtech.spaceshooter.helpers.MouseFollower;
	import jaxrtech.spaceshooter.helpers.MouseManager;
	
	public class PlayerShip extends BaseUpdatingSprite implements IMouseHandler, IKillable
	{
		private const SPEED:int = 5;
		private const SHOOT_WAIT_MS:int = 100;
		
		private var keys:Array = [Keyboard.UP,
								  Keyboard.DOWN,
								  Keyboard.LEFT,
								  Keyboard.RIGHT,
								  Keyboard.SPACE]
		private var keyboardManager:KeyboardManager = new KeyboardManager(keys);
		
		private var shipMouseFollower:MouseFollower = new MouseFollower(this as Sprite);
		private var mouseHandler:MouseManager = new MouseManager(this as IMouseHandler);
		
		private var shootTimer:Timer = new Timer(SHOOT_WAIT_MS);
		
		private var _health:int = 100;
			
		public function PlayerShip()
		{
			super();
		}
		
		public override function enable():void
		{
			super.enable();
			this.stage.addChild(keyboardManager);
			this.stage.addChild(shipMouseFollower);
			this.stage.addChild(mouseHandler);
		}
		
		public override function disable():void
		{
			super.disable();
			this.stage.removeChild(keyboardManager);
			this.stage.removeChild(shipMouseFollower);
			this.stage.removeChild(mouseHandler);
		}
		
		protected override function update(e:Event):void
		{
			handlePositionKeypresses();
		}
		
		private function handlePositionKeypresses():void
		{
			if (keyboardManager.isKeyDown(Keyboard.UP))
			{
				this.y -= SPEED;
			}
			if (keyboardManager.isKeyDown(Keyboard.DOWN))
			{
				this.y += SPEED;
			}
			if (keyboardManager.isKeyDown(Keyboard.LEFT))
			{
				this.x -= SPEED; 
			}
			if (keyboardManager.isKeyDown(Keyboard.RIGHT))
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
			Game.bullets.push(bullet);
		}
		
		public function get health():int
		{
			return _health;
		}
		
		public function set health(h:int):void
		{
			_health = h;
		}
	}
}