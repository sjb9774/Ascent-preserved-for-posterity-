package com.ascent.game.basicobject 
{
	import com.ascent.game.event.ControlEvent;
	import com.ascent.game.player.PlayerDirection;
	import flash.events.Event;
	/**
	 * ...
	 * @author Stephen Biston
	 */
	 
	public class MobileObject extends PhysicalObject
	{
		private var _hSpeedModifier:Number;
		private var _vSpeedModifier:Number;
		
		protected var _movingLeft:Boolean;
		protected var _movingRight:Boolean;
		
		protected var _direction:String;
		
		public function MobileObject() 
		{
			_hSpeedModifier = 1;
			_vSpeedModifier = 1;
			_weight = 1;
		}
		
		public function moveLeft():void
		{
			movingLeft = true;
			direction = PlayerDirection.LEFT;
		}
		
		public function moveRight():void
		{
			movingRight = true;
			direction = PlayerDirection.RIGHT;
		}
		
		public function stop():void
		{
			movingRight, movingLeft = false, false;
		}
		
		public function jump():void
		{
			if ( !airborne ) 
			{
				dispatchEvent( new ControlEvent( ControlEvent.JUMP, true ) );
			}
		}
		
		public function crouch():void
		{
			
		}
		
		public function attack():void
		{
			
		}
		
		public function get hSpeedModifier():Number
		{
			return _hSpeedModifier
		}
		
		public function get vSpeedModifier():Number
		{
			return _vSpeedModifier;
		}
		
		public function get weight():Number
		{
			return _weight;
		}
		
		public function get movingLeft():Boolean
		{
			return _movingLeft;
		}
		
		public function get movingRight():Boolean
		{
			return _movingRight;
		}
		
		public function get direction():String
		{
			return _direction;
		}
		
		public function set hSpeedModifier( value:Number ):void
		{
			_hSpeedModifier = value;
		}
		
		public function set vSpeedModifier( value:Number ):void
		{
			_vSpeedModifier = value;
		}
		
		public function set weight( value:Number ):void
		{
			if ( value < 0 ) weight = 0;
			else _weight = value;
		}
		
		override public function set airborne( value:Boolean ):void
		{
			if ( !value && !movingLeft && !movingRight ) this.velocity.x = 0;
			trace( "moving left? " + movingLeft.toString() + "		moving right?" + movingRight.toString() );
			_airborne = value;
		}
		
		public function set movingRight( value:Boolean ):void
		{
			_movingRight = value;
		}
		
		public function set movingLeft( value:Boolean ):void
		{
			_movingLeft = value;
		}
		
		public function set direction( value:String ):void
		{
			_direction = value;
		}
		
		
	}

}