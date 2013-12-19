package com.ascent.game.event 
{
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class ControlEvent extends AscentEvent 
	{
		public static const JUMP:String = "jump";
		
		public function ControlEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
		}
		
	}

}