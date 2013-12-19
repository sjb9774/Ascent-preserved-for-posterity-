package com.ascent.game.basicobject 
{
	import starling.display.Sprite;
	/**
	 * Base class for all objects that the player or NPCs can attack, destroy, activate, or otherwise interact with.
	 * @author Stephen Biston
	 * 
	 */
	public class InteractiveObject extends Sprite
	{
		private var _solid:Boolean;
		
		/**
		 * Base class for all objects that the player or NPCs can attack, destroy, activate, or otherwise interact with.
		 */
		public function InteractiveObject() 
		{
		}
		
		/**
		 * Activates the object. Activated objects are available affected by all the environments, physics, 
		 * and other InteractiveObjects they are associated with.
		 */
		public function activate():void
		{
			
		}
		
		/**
		 * Gets or sets a true/false value determining whether or not other InteractiveObjects can pass through this object.
		 */
		public function get solid():Boolean
		{
			return _solid;
		}
		
		private function set solid( value:Boolean ):void
		{
			_solid = value;
		}
	
	}

}