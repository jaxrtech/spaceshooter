package jaxrtech.spaceshooter.managers
{
	import flash.events.*;
	import flash.system.Capabilities;
	import flash.utils.Dictionary;
	
	import jaxrtech.spaceshooter.base.BaseSprite;
	
	public class KeyboardManager extends BaseSprite
	{
		private var keyStates:Dictionary = new Dictionary();
		
		/**
		 * Create a new KeybaordManager
		 * 
		 * @param keys  An array of the keys to listen for
		 */
		public function KeyboardManager(keys:Array)
		{
			super();
			
			if (Capabilities.isDebugger)
			{
				for each (var key in keys)
				{
					keyStates[key] = false;	
					trace("key = " + key + "; value = " + keyStates[key]);
				}
			}
		}
		
		public override function enable():void
		{
			super.enable();
			
			reset();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyPressDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyPressUp);
		}
		
		public override function disable():void
		{
			super.disable();
			
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyPressDown);
			stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyPressUp);
			
			reset();
		}
		
		private function reset():void
		{
			for each (var key in keyStates)
			{
				keyStates[key] = false;
			}
		}
		
		public function isKeyDown(key:uint):Boolean
		{
			return keyStates[key];
		}
		
		private function onKeyPressDown(event:KeyboardEvent):void
		{
			for (var key in keyStates)
			{
				if (event.keyCode == key)
				{
					keyStates[key] = true;
				}
			}
		}
		
		private function onKeyPressUp(event:KeyboardEvent):void
		{
			for (var key in keyStates)
			{
				if (event.keyCode == key)
				{
					keyStates[key] = false;
				}
			}
		}
	}
}