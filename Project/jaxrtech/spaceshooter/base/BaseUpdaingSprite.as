package jaxrtech.spaceshooter.base
{
	import flash.events.*;
	import flash.utils.*;
	
	public class BaseUpdaingSprite extends BaseServicingSprite implements IUpdating
	{
		public function BaseUpdaingSprite()
		{
			super();
			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == BaseUpdaingSprite)
				throw new Error("BaseUpdatingSprite must not be directly instantiated");
		}
		
		public override function enable():void
		{
			super.enable();
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		public override function disable():void
		{
			super.disable();
			stage.removeEventListener(Event.ENTER_FRAME, update);
		}
		
		/**
		 * [Virtual method]
		 * Called each time a new frame is about to be drawn
		 */
		public function update(e:Event):void { }
	}
}