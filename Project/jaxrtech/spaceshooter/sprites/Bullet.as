﻿package jaxrtech.spaceshooter.sprites
{
	import flash.events.*;
	
	import jaxrtech.spaceshooter.base.BaseUpdaingSprite;
	import jaxrtech.spaceshooter.traits.IProjectile;
	
	public class Bullet extends BaseUpdaingSprite implements IProjectile
	{
		public const DEFAULT_SPEED:Number = 10;
		public const DEFAULT_DAMAGE:Number = 7;
		
		private var _damage:int = DEFAULT_DAMAGE;
		private var _movementSpeed:Number = DEFAULT_SPEED;
		
		public function Bullet()
		{
			super();
		}
		
		public override function update(e:Event):void
		{
			var angle:Number = ((this.rotation - 90) * Math.PI / 180);
			x = x + movementSpeed * Math.cos(angle);
			y = y + movementSpeed * Math.sin(angle);
		}
		
		public function get movementSpeed():Number
		{
			return this._movementSpeed;
		}
		
		public function set movementSpeed(s:Number):void
		{
			this._movementSpeed = s;
		}
		
		public function get damage():Number
		{
			return this._damage;
		}
		
		public function set damage(d:Number):void
		{
			this._damage = d;
		}
	}
}