package com.ascent.game.environment
{
	import com.ascent.game.level.blocks.Block;
	import com.ascent.game.level.blocks.BlockStandards;
	import com.ascent.game.player.Player;
	import flash.display.Shape;
	import flash.display.Sprite;
	import starling.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import util.StarlingGeometry.Collision;
	import com.ascent.game.basicobject.PhysicalObject;
	
	/**
	 * Defines a set of Physics operations that control a set of objects associated with the PhysicsEnvironment.
	 * Any object added with the addObject() method will be subject to these physics-simulating effects as long
	 * as the start() method has been called with no subsequent calls to the stop() method.
	 * @author Stephen Biston
	 */
	
	public class PhysicsEnvironment
	{
		private var _bs:int;
		private var _objects:Vector.<PhysicalObject>;
		private var _obstacles:Vector.<PhysicalObject>;
		private var _active:Boolean;
		private var _g:Number;
		private var _drag:Number;
		private var _wind:Number;
		private var _termVelocity:Number;
		private var _boundingRectangle:Rectangle;
		private var _stage:Stage;
		
		public function PhysicsEnvironment( stage:Stage, boundingRect:Rectangle=null ):void
		{
			_bs = BlockStandards.BLOCK_SIZE;
			_stage = stage;
			
			if ( !boundingRect ) _boundingRectangle = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
			else _boundingRectangle = boundingRect;
			
			_objects = new Vector.<PhysicalObject>();
			_obstacles = new Vector.<PhysicalObject>();
			_active = false;
			
			_g = 1.3;
			_drag = 1.5;
			_wind = -1;
		}
		/**
		 * The execution of all the physics-simulation goes here. Every frame the objects associated with the
		 * PhysicsEnvironment are iterated through and their distances are calculated between the bounding box, other objects,
		 * and obstacles. The appropriate response for the object is calculated and executed based on the values from both
		 * the PhysicsEnvironment (gravity, drag, etc) and the PhysicalObject (weight, bounciness, etc).
		 */
		public function onFrame( ):void
		{
			if ( _objects.length == 0 ) return;
			
			if ( _active )
			{
				for each( var obj:PhysicalObject in _objects )
				{
					var nextFramePos:Point = nextFramePosition( obj, true );
					
					for each( var block:PhysicalObject in _obstacles )
					{
						if ( Collision.rectanglesTouch( nextFramePos.x, nextFramePos.x + obj.width, nextFramePos.y, nextFramePos.y + obj.height,
														block.x, block.x + _bs, block.y, block.y + _bs ) )
						{
							if( obj.airborne && obj.velocity.y > 0 ){
								
								obj.airborne = false;
								obj.velocity.y = 0;
								nextFramePos = new Point( nextFramePos.x, obj.y );
								//obj.velocity.y = 0;
								obj.y = block.y - obj.height
							}
							else if ( obj.velocity.y == 0 )
							{
								trace( "o vel" );
								//obj.velocity.y = 0;
								//obj.y = block.y - obj.height;
							}
						}
						else if ( obj.airborne )
						{
							obj.velocity.y += _g;
						}
						obj.x = nextFramePos.x;
						obj.y = nextFramePos.y;
					}
					
				}
			}
		}
		
		/**
		 * When called, all objects associated with the PhysicsEnvironment will begin being acted upon by the physics simulation.
		 */
		public function start():void
		{
			_active = true;
		}
		
		/**
		 * When called, all objects associated with the PhysicsEnvironemt will cease being affected by the physics simulation.
		 */
		public function stop():void
		{
			_active = false;
		}
		
		/**
		 * Use this method to add a PhysicalObject you wish to be subject to this PhysicsEnvironment's simulation.
		 * @param	obj The PhysicslObject that will be subject to the simulation.
		 */
		public function addObject( obj:PhysicalObject ):void
		{
			obj.velocity.y = _g;
			_objects.push( obj );
		}
		
		/**
		 * Use this method to remove a PhysicslObject from the PhysicsEnvironment. This method should be called on PhysicalObjects
		 * that are removed from the stage or otherwise not needed.
		 * @param	obj The PhysicalObject that will be removed from the PhysicsEnvironment, if it is in it.
		 * @return Returns true if the PhysicalObject was found and removed, otherwise false.
		 */
		public function removeObject( obj:PhysicalObject ):Boolean
		{
			for ( var x:uint = 0 ; x < _objects.length ; x++ )
			{
				if ( _objects[x] === obj )
				{
					_objects.splice( x, 1 );
					return true;
				}
			}
			return false
		}
		
		/**
		 * Use this method when you're adding walls/platforms/etc that you do not want to fall by physics, but you do want the
		 * objects affect by gravity, drag, etc. to be tested against for collision.
		 * 
		 * @param	obj
		 */
		public function addObstacle( obj:PhysicalObject ):void
		{
			_obstacles.push( obj );
		}
		/**
		 * Calculates the x and y-positions of a PhysicalObject on the next frame based on the object's velocity. This method
		 * is called with updateVelocity as true on every PhysicalObject associated with this PhysicsEnvironment every frame.
		 * 
		 * @param	obj The PhysicalObject whose next position will be calculated.
		 * @param	updateVelocity If true, the velocity will be changed based on variables of the PhysicsEnvironment
		 * 	(gravity, drag, etc).
		 * 
		 * @return Returns a Point object that corresponds to the calculated next-frame-position of the PhysicalObject passed 
		 * to this method.
		 */
		public function nextFramePosition( obj:PhysicalObject, updateVelocity:Boolean = false ):Point
		{
			if ( !obj._active )
			{
				return new Point( obj.x, obj.y );
			}
			
			var p:Point = new Point();
			p.x = obj.x + ( obj.velocity.x / (  obj._frictionMultiplier ) )
			p.y = obj.y + ( (obj.velocity.y * _g ) / obj._frictionMultiplier );
			if ( !obj.airborne ) p.y = obj.y;
			if ( updateVelocity )
			{
				//obj.velocity.x -=  obj.velocity.x * .025;
				obj.velocity.y += _g / _drag 
			}
			
			return p;
		}
		
		public function vectorDisplay( obj:PhysicalObject ):Sprite
		{
			var sprite:Sprite = new Sprite();
			
			sprite.graphics.moveTo( 100, 100 );
			sprite.graphics.lineStyle( 2, 0, 1 );
			sprite.graphics.lineTo(  100 + obj.velocity.x, 100 + obj.velocity.y );
			
			return sprite;
			
		}
		
		/**
		 * Gets or sets the gravity value of the PhysicsEnvironment. Determines how fast objects associated with this environment fall.
		 */
		public function get gravity():Number
		{
			return _g;
		}
		
		public function set gravity( value:Number ):void
		{
			_g = value;
		}
	}
	
}