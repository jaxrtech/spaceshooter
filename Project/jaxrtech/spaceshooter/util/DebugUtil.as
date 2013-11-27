package jaxrtech.spaceshooter.util
{
	import flash.display.Stage;
	
	public class DebugUtil
	{	
		public static function traceStageChildren(stage:Stage):void
		{
			trace ("stage.length = " + stage.numChildren);
			for (var i:int = 0; i < stage.numChildren; i++)
			{
				trace("> " + stage.getChildAt(i).name);
			}
		}
	}
}