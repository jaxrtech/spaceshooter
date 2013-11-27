package jaxrtech.spaceshooter.helpers
{
	import flash.events.*;
	import flash.utils.*;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	
	public class MouseManager extends BaseSprite
	{
		var handler:IMouseHandler;
		
		public function MouseManager(handler:IMouseHandler)
		{
			super();
			this.handler = handler;
		}
		
		public override function enable():void
		{
			super.enable();
			stage.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
		}
		
		public override function disable():void
		{
			super.disable();
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, drag);
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			stage.addEventListener(Event.MOUSE_LEAVE, endDrag);
			
			handler.onBeginDrag(e);
		}
		
		private function drag(e:MouseEvent):void
		{
			handler.onDrag(e);
		}
		
		private function endDrag(e:Event):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, drag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			stage.removeEventListener(Event.MOUSE_LEAVE, endDrag);
			
			handler.onEndDrag(e);
		}
	}
}