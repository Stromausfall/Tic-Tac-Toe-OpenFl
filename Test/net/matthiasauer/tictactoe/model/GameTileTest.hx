package net.matthiasauer.tictactoe.model;
import haxe.unit.TestCase;

/**
 * ...
 * @author Matthias Auer
 */
class GameTileTest extends TestCase
{
	public function testCheckXAndYCoordinates() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		
		assertEquals(2, tile.getX());
		assertEquals(1, tile.getY());
	}
	
}