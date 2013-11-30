package jaxrtech.spaceshooter.base
{
	import flash.display.DisplayObject;
	
	import jaxrtech.spaceshooter.util.Util;

	public class BaseServicingSprite extends BaseSprite
	{
		private var serviceArrays:Array = new Array();
		private var stageObjects:Array = new Array();
		
		public function BaseServicingSprite()
		{
			super();
		}
		
		protected final function addServiceArray(array:Array):void
		{
			serviceArrays.push(array);
		}
		
		protected final function addStageObject(obj:BaseSprite):void
		{
			stageObjects.push(obj);
		}
		
		protected final function removeServiceArray(array:Array):void
		{
			Util.removeFromArray(serviceArrays, array);
		}
		
		protected final function removeStageObject(obj:BaseSprite):void
		{
			Util.removeFromArrayAndStage(stage, stageObjects, obj);
		}
		
		private function addStageServices():void
		{
			for each (var obj:BaseSprite in stageObjects)
			{
				stage.addChild(obj);
			}
		}
		
		private function removeStageServices():void
		{
			for each (var obj:BaseSprite in stageObjects)
			{
				stage.removeChild(obj);
			}
		}
		
		/**
		 * [Virtual function]
		 * Used to configure and add services so that they can then be automaitcally managed using
		 * the IService methods.
		 * 
		 * @see IService
		 */
		protected function config():void { }
		
		public override function init():void
		{
			super.init();
			
			config();
			addStageServices();
			for each (var service:BaseSprite in stageObjects)
			{
				service.init();
			}
		}
		
		public override function enable():void
		{
			super.enable();
			
			for each (var service:IService in stageObjects)
			{
				service.enable();
			}
		}
		
		public override function disable():void
		{
			super.disable();
			
			for each (var service:IService in stageObjects)
			{
				service.disable();
			}
			
			for each (var array:Array in serviceArrays)
			{
				Util.applyToArray(array, function(service:IService):void
				{
					service.disable();
				});
			}
		}
		
		public override function destroy():void
		{
			super.destroy();
			
			removeStageServices();
			for each (var service:IService in stageObjects)
			{
				service.destroy();
			}
		}
	}
}