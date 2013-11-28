package jaxrtech.spaceshooter.base
{
	import flash.display.Sprite;
	import flash.errors.IllegalOperationError;
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.*;
	
	public class BaseSprite extends Sprite implements IBaseSprite
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
				throw new IllegalOperationError("BaseSprite must not be directly instantiated");
			
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
			this.init();
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
			if (Capabilities.isDebugger)
			{
				trace(getQualifiedClassName(this) + " was destroyed.");
			}
			
			this.disable();
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.removeEventListener(Event.REMOVED, onRemove);
		}
		
		/**
		 * [Virtual method]
		 * Used to initilize add children to the stage and initially configure any objects or 
		 * states.
		 * <br/>
		 * Note: This is called only when the object had been added or readded to the stage.
		 */
		public function init():void
		{
			if (Capabilities.isDebugger)
			{
				trace(getQualifiedClassName(this) + " was initialized.");
			}
		}
		
		/**
		 * [Virtual method]
		 * Used to enable custom event listeners to fire and other components at the point that the 
		 * sprite is added to the stage. 
		 * <br/>
		 * Note: This method is also called when the object resumes from a disble() call.
		 */
		public function enable():void 
		{
			if (Capabilities.isDebugger)
			{
				trace(getQualifiedClassName(this) + " was enabled.");
			}
		}
		
		/**
		 * [Virtual method]
		 * Used to disble custom event listeners from firing and other components. Note that this
		 * method can be envoked at any time.
		 * <br/>
		 * Note: An enable() call can be envoked after this method.
		 */
		public function disable():void
		{
			if (Capabilities.isDebugger)
			{
				trace(getQualifiedClassName(this) + " was disabled.");
			}
		}
		
	}
}