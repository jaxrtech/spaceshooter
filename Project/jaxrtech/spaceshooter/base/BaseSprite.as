package jaxrtech.spaceshooter.base
{
	import flash.display.Sprite;
	import flash.events.*;
	import flash.utils.*;
	
	public class BaseSprite extends Sprite
	{
		/**
		 * [Abstract Class]
		 * This contructor should <i>not</i> be used since this class functions as if it was 
		 * absract.
		 * An error is thrown otherwise.
		 */
		public function BaseSprite()
		{
			super();
			
			if (Class(getDefinitionByName(getQualifiedClassName(this))) == BaseSprite)
				throw new Error("BaseSprite must not be directly instantiated");
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Handles the event that is fired when the sprite is added to the stage
		 * 
		 * @param e	the event
		 */
		protected function onAddedToStage(e:Event):void
		{
			//trace(getQualifiedClassName(this) + " added to stage");
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.enable();
			this.addEventListener(Event.REMOVED, onRemove);
		}

		/**
		 * Handles the event that is fired when the sprite is removed as a child
		 * 
		 * @param e	the event
		 */
		protected function onRemove(e:Event):void
		{
			this.removeEventListener(Event.REMOVED, onRemove);
			this.disable();
			// It can still be added back though
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		/**
		 * Permenantly destroys the sprite so that it cannot be used again.
		 */
		public function destroy():void
		{
			this.disable();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.removeEventListener(Event.REMOVED, onRemove);
		}
		
		/**
		 * [Virtual method]
		 * Used to add custom event listeners and other components at the point that the sprite is 
		 * added to the stage
		 */
		public function enable():void { }
		
		/**
		 * [Virtual method]
		 * Used to remove custom event listeers and other componets at the point that the sprite is
		 * removed as a child
		 */
		public function disable():void { }
		
	}
}