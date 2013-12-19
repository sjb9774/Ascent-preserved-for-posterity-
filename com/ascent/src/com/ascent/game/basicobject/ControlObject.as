package com.ascent.game.basicobject 
{
	import com.ascent.game.basicobject.PhysicalObject;
	
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class ControlObject extends MobileObject
	{
		
		public function ControlObject() 
		{
			
		}
		
		override public function stop():void
		{
			movingLeft, movingRight = false, false;
		}
		

	}

}