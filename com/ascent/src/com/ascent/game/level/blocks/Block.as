package com.ascent.game.level.blocks
{
	import com.ascent.game.basicobject.PhysicalObject;
	import starling.display.Image;
	
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class Block
	{
		protected var _solid:Boolean;
		protected var _x:int;
		protected var _y:int;
		protected var _type:int;
		
		public function Block(xpos:int, ypos:int, type:int, solid:Boolean = true)
		{
			_x = xpos;
			_y = ypos;
			_type = type;
			_solid = solid;
			
			//this.texture = BlockMap.getTexture( type );
		}
		
		public static function getBlockFromString(str:String):Block
		{
			var x:int = int(str.substr(0, 2 ));
			var y:int = int(str.substr( 2, 2 ));
			var type:int = int(str.substr(4, 3));
			var solidNum:int = int(str.charAt(str.length - 1));
			var solid:Boolean = solidNum == 1 ? true : false;
			trace( x, y, type, solid );
			return new Block(x, y, type, solid);
		}
		
		public function get width():Number
		{
			return BlockStandards.BLOCK_SIZE;
		}
		
		public function get height():Number
		{
			return BlockStandards.BLOCK_SIZE;
		}
		
		public function get y():int
		{
			return _y;
		}
		
		public function get x():int
		{
			return _x;
		}
		
		public function get type():int 
		{
			return _type;
		}
	
	}
}