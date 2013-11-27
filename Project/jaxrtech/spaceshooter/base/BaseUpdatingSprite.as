package jaxrtech.spaceshooter.base
{
	import flash.utils.*;
	import flash.events.*;
	
	public class BaseUpdatingSprite extends BaseSprite
	{
		public function BaseUpdatingSprite()
		{
			super();
			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == BaseUpdatingSprite)
				throw new Error("BaseUpdatingSprite must not be directly instantiated");
		}
		
		public override function enable():void
		{
			this.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public override function disable():void
		{
			this.stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * [Virtual method]
		 * Called each time a new frame is about to be drawn
		 */
		protected function update(e:Event):void { }
	}
}