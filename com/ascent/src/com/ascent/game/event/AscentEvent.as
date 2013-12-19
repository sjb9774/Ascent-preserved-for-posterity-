package com.ascent.game.event 
{
	import starling.events.Event;
	
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class AscentEvent extends Event 
	{
		
		public function AscentEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
		}
		
	}

}