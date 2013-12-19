package com.ascent.game.environment 
{
	import com.ascent.game.basicobject.PhysicalObject;
	import com.ascent.game.level.blocks.Block;
	import com.ascent.game.level.Level;
	import com.ascent.game.player.Player;
	import flash.geom.Rectangle;
	import starling.display.Sprite;
	import com.ascent.game.event.ControlEvent;
	import flash.events.Event;
	import com.ascent.game.level.blocks.BlockStandards;
	/**
	 * Represents the level being played as a whole. Contains the Player object, a PhysicsEnvironmentObject which determines
	 * how the player and NPCs can move through the Level object also contained by Environment, defining boundaries for movement,
	 * walls, floors, ceilings, etc, as well as texturing information.
	 * 
	 * @author Stephen Biston
	 * 
	 */
	public class Environment extends Sprite
	{
		private var _player:Player;
		private var _level:Level;
		private var _physics:PhysicsEnvironment;
		
		private var _baseV:Number = 20;
		private var _v:Number = 20;
		private var _terminalV:Number = 10;
		
		/**
		 * Creates a new Environment object. An Environment generally corresponds to a single world or level that a player may play on.
		 * 
		 * @param	player The Player object that will be controlled by the user and directed through the Environment.
		 * @param	level The Level object that defines the walls, floors, obstacles, boundaries, and textures for the Environment.
		 * @param	physics The PhysicsEnvironment object that controls how the player and NPCs can move through the Environment.
		 */
		public function Environment( player:Player, level:Level, physics:PhysicsEnvironment ) 
		{
			_player = player;
			_level = level;
			_physics = physics;
			
			setUpEnvironment();
			
		}
		
		
		private function setUpEnvironment():void
		{
			_player.addEventListener( ControlEvent.JUMP, playerJump );
			
			addLevelToPhysics( _level, _physics );
			
			_physics.addObject( player );
			_physics.start();
			
			this.display();
		}
		/**
		 * Displays the visual components of the Environment on its own stage. This method should be called with this
		 * Environment object added as a child to the main Stage (or as child of child of the main Stage, etc ).
		 */
		public function display():void
		{
			_player.x = 20
			_player.y = 100;
			_level.renderLevel();
			this.addChild( _level );
			this.addChild( _player );
		}
		
		
		private function addLevelToPhysics( level:Level, physics:PhysicsEnvironment = null ):void
		{
			var phy:PhysicsEnvironment = physics ? physics : this._physics;
			for each( var block:Block in level.wallBlocks )
			{
				var phyObj:PhysicalObject = new PhysicalObject();
				phyObj.width = BlockStandards.BLOCK_SIZE;
				phyObj.height = BlockStandards.BLOCK_SIZE;
				phyObj.x = block.x * BlockStandards.BLOCK_SIZE;
				phyObj.y = block.y * BlockStandards.BLOCK_SIZE;
				phyObj._active = false;
				phy.addObstacle( phyObj );
			}
		}
		/**
		 * Private. Determines what happens when a ControlEvent.JUMP event is heard from the Player object. ControlEvent.JUMP
		 * is typically dispatched from the Player when the user presses the Jump key.
		 * 
		 * @param	e The ControlEvent dispatched from the Player.
		 */
		private function playerJump( e:ControlEvent ):void
		{
			if ( player.airborne ) return;
			player.airborne = true;
			player.velocity.y = -10;
		}
		
		/**
		 * Gets or sets the Player object associated with this Environment. Settings the Player object with a new Player will
		 * remove the old Player object from the Environment.
		 */
		public function get player():Player
		{
			return _player;
		}
		
		public function set player( value:Player ):void
		{
			this.removeChild( _player );
			this.addChild( value );
			_player = value;
		}
		/**
		 * Read-only. Returns the Level object associated with this Environment. If you wish to set a new level to an Environment,
		 * it is advised that you create a new Environment wit th desired Level and Player instead.
		 */
		public function get level():Level
		{
			return _level;
		}
		
		private function set level( value:Level ):void
		{
			_level = value;
		}
		
	}

}