package com.ascent.game.level
{
	import com.ascent.game.level.blocks.Block;
	import com.ascent.game.level.blocks.BlockStandards;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.display.Sprite;
	import com.ascent.game.level.blocks.BlockMap;
	
	/**
	 * ...
	 * @author Stephen Biston
	 */
	public class Level extends Sprite
	{
		
		[Embed(source="../../../../../assets/levelxml/Levels.xml",mimeType="application/octet-stream")]
		public static const LevelXML:Class;
		
		public static var levels:Vector.<Level> = new Vector.<Level>();
		
		public var wallBlocks:Vector.<Block>;
		public var prettyBlocks:Vector.<Block>;
		public var interactiveBlocks:Vector.<Block>;
		
		public function Level()
		{
			wallBlocks = new Vector.<Block>();
			prettyBlocks = new Vector.<Block>();
			interactiveBlocks = new Vector.<Block>();
		}
		
		public static function parseLevels():void
		{
			var xml:XML = new XML(new LevelXML());
			
			for each (var levelString:String in xml.children())
			{
				var lvl:Level = new Level();
				for each (var blockString:String in levelString.split("-"))
				{
					var block:Block = Block.getBlockFromString(blockString);
					
					if (BlockStandards.isBasic(block))
					{
						lvl.wallBlocks.push(block);
					}
					else if (BlockStandards.isInteractive(block))
					{
						lvl.interactiveBlocks.push(block);
					}
				}
				Level.levels.push(lvl);
			}
		}
		
		public function renderLevel():void
		{
			for each (var block:Block in this.wallBlocks)
			{
				var i:Image = new Image(BlockMap.getTexture(block.type));
				i.x = block.x * BlockStandards.BLOCK_SIZE;
				i.y = block.y * BlockStandards.BLOCK_SIZE;
				i.width = BlockStandards.BLOCK_SIZE;
				i.height = BlockStandards.BLOCK_SIZE;
				this.addChild(i);
			}
			
			for each (var block1:Block in this.interactiveBlocks)
			{
				var j:Image = new Image(BlockMap.getTexture(block1.type));
				j.x = block1.x * BlockStandards.BLOCK_SIZE;
				j.y = block1.y * BlockStandards.BLOCK_SIZE;
				j.width = BlockStandards.BLOCK_SIZE;
				j.height = BlockStandards.BLOCK_SIZE;
				this.addChild(j);
			}
			
			for each (var block2:Block in this.prettyBlocks)
			{
				var k:Image = new Image(BlockMap.getTexture(block2.type));
				k.x = block2.x * BlockStandards.BLOCK_SIZE;
				k.y = block2.y * BlockStandards.BLOCK_SIZE;
				k.width = BlockStandards.BLOCK_SIZE;
				k.height = BlockStandards.BLOCK_SIZE;
				this.addChild(k);
			}
		}
		

	
	}

}