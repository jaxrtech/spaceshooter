package jaxrtech.spaceshooter.helpers
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.Point;
	
	import jaxrtech.spaceshooter.base.BaseUpdatingSprite;
	
	public class MouseFollower extends BaseUpdatingSprite
	{
		private static const RAD_TO_DEG:Number = 180.0 / Math.PI;
		private static const DEG_TO_RAD:Number = Math.PI / 180.0;
		private static const OFFSET:Number = 90;
		
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
		
		protected override function update(e:Event):void
		{
			_generatedRotation = getRotationTowardsPoint(new Point(object.x, object.y), 
														 new Point(mouseX, mouseY));
			object.rotation = _generatedRotation;
		}
		
		public function get generatedRotation():int
		{
			return _generatedRotation;
		}
		
		public static function getRotationTowardsObject(origin:DisplayObject, 
														target:DisplayObject):Number
		{
			return getRotationTowardsPoint(new Point(origin.x, origin.y),
										   new Point(target.x, target.y));
		}
		
		public static function getRotationTowardsPoint(origin:Point, target:Point):Number
		{
			var radians:Number = Math.atan2(target.y - origin.y, target.x - origin.x);
			var angle:Number = radians * RAD_TO_DEG;
			
			return angle + OFFSET;
		}
		
		public static function moveObjectTowardTargetAtDelta(origin:DisplayObject, 
															 target:DisplayObject,
													   		 delta:Number):void
		{
			var point = getPointTowardTargetAtDelta(new Point(origin.x, origin.y),
												    new Point(target.x, target.y),
													delta);
			origin.x = point.x;
			origin.y = point.y;
		}
		
		public static function getPointTowardTargetAtDelta(origin:Point, target:Point,
														   delta:Number):Point
		{
			var rotation:Number = getRotationTowardsPoint(origin, target);
			var angle:Number = (rotation - OFFSET) * DEG_TO_RAD;
			
			var point:Point = new Point();
			point.x = origin.x + delta * Math.cos(angle);
			point.y = origin.y + delta * Math.sin(angle);
			
			return point
		}
	}
}