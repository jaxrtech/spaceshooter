package jaxrtech.spaceshooter.util
{
	import flash.display.Stage;
	import flash.display.DisplayObject;

	public class Util
	{
		public static function removeFromStageAndArray(stage:Stage, vector:Array,
													   object:DisplayObject):void
		{
			stage.removeChild(object);
			var i:int = vector.indexOf(object);
			vector.splice(i, 1);
		}
	}
}