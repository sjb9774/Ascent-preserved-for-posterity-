package com.ascent.game.player 
{
	import com.ascent.game.interfaces.IComplexAnimator;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.animation.Juggler;
	import starling.core.Starling;
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class Avatar extends Sprite implements IComplexAnimator
	{
		protected var _currentClip:MovieClip;
		protected var _defaultClip:MovieClip;
		protected var _walkRightClip:MovieClip;
		protected var _walkLeftClip:MovieClip;
		
		public function Avatar() 
		{
		}
		
		public function pauseAnimation():void { }
		public function resumeAnimation():void { }
		public function stand():void { }
		public function jump():void { }
		public function fall():void { }
		public function spawn():void { }
		public function die():void { }
		public function attack():void { }
		
		
		public function playCurrent():void
		{
			currentClip.visible = true;
			Starling.juggler.add( currentClip );
		}
		
		public function animate():void
		{
			if( currentClip ) currentClip.visible = false;
			currentClip = defaultClip;
			playCurrent();
		}
		
		public function walkRight():void
		{
			currentClip.visible = false;
			currentClip = walkRightClip;
			playCurrent();
		}
		
		public function walkLeft():void
		{
			currentClip.visible = false;
			currentClip = walkLeftClip;
			playCurrent();
		}
		
		public function get defaultClip():MovieClip
		{
			return _defaultClip;
		}
		
		public function get walkRightClip():MovieClip
		{
			return _walkRightClip;
		}
		
		public function get walkLeftClip():MovieClip
		{
			return _walkLeftClip;
		}
		
		public function get currentClip():MovieClip
		{
			return _currentClip;
		}
		
		public function set defaultClip( value:MovieClip ):void
		{
			_defaultClip = value;
		}
		
		public function set walkRightClip( value:MovieClip ):void
		{
			_walkRightClip = value;
		}
		
		public function set walkLeftClip( value:MovieClip ):void
		{
			_walkLeftClip = value;
		}
		
		public function set currentClip( value:MovieClip ):void
		{
			_currentClip = value;
		}
	}

}