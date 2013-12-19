package com.ascent 
{
	import com.ascent.game.basicobject.InteractiveObject;
	import com.ascent.game.control.Controller;
	import com.ascent.game.environment.Environment;
	import com.ascent.game.environment.PhysicsEnvironment;
	import com.ascent.game.level.Level;
	import com.ascent.game.player.AndyAvatar;
	import com.ascent.game.player.BoyAvatar;
	import com.ascent.game.player.Player;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import starling.animation.Juggler;
	import starling.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class Game extends Sprite
	{
		private var _stage:Stage;
		private var _phys:PhysicsEnvironment;
		
		public function Game( ) 
		{
			this.addEventListener( Event.ADDED_TO_STAGE, init );
		}
		
		private function init( e:Event ):void
		{
			setUp();
			start();
		}
		private function setUp():void
		{
			Level.parseLevels();
		}
		public function start():void
		{	
			var avatar:BoyAvatar = new BoyAvatar();
			var player:Player = new Player( avatar );
			var level:Level = Level.levels[0];
			_phys = new PhysicsEnvironment( stage );
			var env:Environment = new Environment( player, level, _phys );
			var controller:Controller = new Controller( player );
			
			stage.addChild( env );
			stage.addChild( controller );
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, keyDown );
			stage.addEventListener( EnterFrameEvent.ENTER_FRAME, enterFrame );

		}
		
		private function enterFrame( e:EnterFrameEvent ):void
		{
			_phys.onFrame();
		}
		
		private function keyDown( e:KeyboardEvent ):void
		{
			if ( e.keyCode == Keyboard.UP )
			{
				_phys.gravity += .5;
			}
			else if ( e.keyCode == Keyboard.DOWN )
			{
				if ( _phys.gravity - .5 > 0 ) _phys.gravity -= .5;
			}
		}
	}

}