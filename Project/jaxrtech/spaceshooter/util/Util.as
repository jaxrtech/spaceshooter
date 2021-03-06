package jaxrtech.spaceshooter.util
{	
	import flash.display.DisplayObject;
	import flash.display.Stage;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	import jaxrtech.spaceshooter.base.IService;

	public class Util
	{	
		public static function removeFromArrayAndStage(stage:Stage, array:Array,
													   object:BaseSprite):void
		{
			object.destroy();
			stage.removeChild(object as DisplayObject);
			var i:int = array.indexOf(object);
			array.splice(i, 1);
		}
		
		public static function removeAllFromArrayAndStage(stage:Stage, array:Array):void
		{
			while (array.length > 0)
			{
				var object = array.pop() as BaseSprite;
				object.destroy();
				stage.removeChild(object);
			}
		}
		
		public static function removeAllStageChildren(stage:Stage):void
		{
			while (stage.numChildren > 0)
			{
				stage.removeChildAt(0);
			}
		}
		
		public static function applyToArray(array:Array, f:Function):void
		{
			for each (var obj in array)
			{
				f(obj);
			}
		}
		
		public static function removeFromArray(array:Array, obj:*):Boolean
		{
			var i:int = array.indexOf(obj);
			if (i < 0) return false;
			
			array.splice(i, 1);
			return true;
		}
	}
}