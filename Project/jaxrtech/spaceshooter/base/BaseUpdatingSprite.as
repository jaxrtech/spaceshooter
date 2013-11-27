package jaxrtech.spaceshooter.base
{
	import flash.events.*;
	import flash.utils.*;
	
	public class BaseUpdatingSprite extends BaseSprite implements IBaseUpdatingSprite
	{
		public function BaseUpdatingSprite()
		{
			super();
			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == BaseUpdatingSprite)
				throw new Error("BaseUpdatingSprite must not be directly instantiated");
		}
		
		public override function enable():void
		{
			super.enable();
			this.stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public override function disable():void
		{
			super.disable();
			this.stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * [Virtual method]
		 * Called each time a new frame is about to be drawn
		 */
		public function update(e:Event):void { }
	}
}