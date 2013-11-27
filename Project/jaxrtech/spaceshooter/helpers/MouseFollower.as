package jaxrtech.spaceshooter.managers
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	import jaxrtech.spaceshooter.util.Targetting;
	
	public class MouseFollower extends BaseUpdatingSprite
	{
		
		private var _generatedRotation:int;
		private var object:Sprite;
		
		public function MouseFollower(object:Sprite)
		{
			super();
			this.object = object;
		}
		
		public override function enable():void
		{
			super.enable();
		}
		
		public override function disable():void
		{
			super.disable();
		}
		
		public override function update(e:Event):void
		{
			_generatedRotation = Targetting.getRotationTowardsPoint(new Point(object.x, object.y), 
														 			new Point(mouseX, mouseY));
			object.rotation = _generatedRotation;
		}
		
		public function get generatedRotation():int
		{
			return _generatedRotation;
		}
	}
}