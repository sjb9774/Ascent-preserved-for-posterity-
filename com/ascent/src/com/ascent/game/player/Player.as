package com.ascent.game.player 
{
	import com.ascent.game.basicobject.ControlObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class Player extends ControlObject
	{
		
		private var _avatar:Avatar;
		
		public function Player( avatar:Avatar ) 
		{
			this.weight = 50;
			this._frictionMultiplier = 1;
			this.hSpeedModifier = 5;
			this._bounciness = 0;
			this._direction = PlayerDirection.RIGHT
			this.airborne = true;
			
			_avatar = avatar;
			this.addChild( avatar );
			avatar.width = 64;
			avatar.height = 64;
			
		}
		
		override public function moveRight():void
		{
			if ( !movingRight )
			{
				movingRight = true;
				direction = PlayerDirection.RIGHT;
			}
		
		}
		
		override public function moveLeft():void
		{
			if ( !movingLeft ) 
			{
				movingLeft = true;
				direction = PlayerDirection.LEFT;
			}
		}
		
		override public function stop():void
		{
			movingLeft, movingRight = false, false;
			avatar.animate();
		}
		
		public function get avatar():Avatar
		{
			return _avatar;
		}
		
		public function set avatar( value:Avatar ):void
		{
			_avatar = value;
		}
		
		override public function set movingRight( value:Boolean ):void
		{
			if ( movingLeft ) movingLeft = false;
			avatar.walkRight();
			if ( !airborne ) 
			{
				if ( value )
				{
					this.velocity.x = 5;
				}
				else
				{
					this.velocity.x = 0;
				}
			}
			else
			{
				if ( value ) this.velocity.x = 2;
			}
			_movingRight = value;
		}
		
		override public function set movingLeft( value:Boolean ):void
		{
			if ( movingRight ) movingRight = false;
			avatar.walkLeft();
			if ( !airborne ) 
			{
				if ( value )
				{
					this.velocity.x = -5;
				}
				else
				{
					this.velocity.x = 0;
				}
			}
			else
			{
				if ( value ) this.velocity.x = -2;
			}
			_movingLeft = value;
		}
		
		override public function set airborne( value:Boolean ):void
		{
			trace( "setting airborne to" + value );
			if ( value )
			{
				//placeholder
			}
			else
			{
				//if left button is held and the player is hitting the ground (airborne being set to false)
				if ( movingLeft ) this.velocity.x = -5;
				//if right button is held and player is hitting the ground
				else if ( movingRight ) this.velocity.x = 5;
				//if neither button is held and the player hits the ground
				else this.velocity.x = 0;
			}
			_airborne = value;
		}
		
		override public function set direction( value:String ):void
		{
			if ( _direction != value )
			{
				if ( value == PlayerDirection.LEFT ) {
					avatar.scaleX = -1;
					_avatar.x += _avatar.width;
				}
				else if ( value == PlayerDirection.RIGHT ) {
					avatar.scaleX = 1;
					_avatar.x -= _avatar.width;
				}
			_direction = value;
			}
		}
		
	}

}