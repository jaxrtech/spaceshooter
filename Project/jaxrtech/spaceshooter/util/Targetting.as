package jaxrtech.spaceshooter.util
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	public class Targetting
	{
		private static const RAD_TO_DEG:Number = 180.0 / Math.PI;
		private static const DEG_TO_RAD:Number = Math.PI / 180.0;
		private static const OFFSET:Number = 90;
		
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