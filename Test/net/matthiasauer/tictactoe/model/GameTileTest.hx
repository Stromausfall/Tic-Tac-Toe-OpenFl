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
	
	public function testInitialPlayer() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		
		assertEquals(tile.getOwner(), Player.None);
	}
	
	public function testSetPlayer() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		assertEquals(tile.getOwner(), Player.None);
		
		tile.setOwner(Player.Human);
		assertEquals(tile.getOwner(), Player.Human);
	}
	
	public function testThatNoneOwnerCannotBeSet() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		var exceptionThrown:Bool = false;
		
		try {
			tile.setOwner(Player.None);
		} catch(msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	public function testThatNullCannotBeSetAsOwner() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		var exceptionThrown:Bool = false;
		
		try {
			tile.setOwner(null);
		} catch(msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	public function testThatOwnerCanOnlyBeAssignedOnce() : Void
	{
		var tile:GameTile = new GameTile(2, 1);
		tile.setOwner(Player.Human);
		var exceptionThrown:Bool = false;
		
		try {
			tile.setOwner(Player.Computer);
		} catch(msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
}