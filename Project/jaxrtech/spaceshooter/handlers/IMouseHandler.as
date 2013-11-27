package jaxrtech.spaceshooter.handlers
{
	import flash.events.MouseEvent;
	import flash.events.Event;

	public interface IMouseHandler
	{
		/**
		 * Called each time the mouse is clicked down
		 */
		function onBeginDrag(e:MouseEvent):void;
		
		/**
		 * Called each time the mouse is dragged
		 */
		function onDrag(e:MouseEvent):void;
		
		/**
		 * Called each time the mouse click is released up or the mouse leaves the stage
		 */
		function onEndDrag(e:Event):void;
	}
}