package net.matthiasauer.tictactoe.model;
import haxe.unit.TestCase;

/**
 * ...
 * @author Matthias Auer
 */
class GameTileTest extends TestCase
{	
	public function testInitialPlayer() : Void
	{
		var tile:GameTile = new GameTile();
		
		assertEquals(tile.getOwner(), Player.None);
	}
	
	public function testSetPlayer() : Void
	{
		var tile:GameTile = new GameTile();
		assertEquals(tile.getOwner(), Player.None);
		
		tile.setOwner(Player.Player1);
		assertEquals(tile.getOwner(), Player.Player1);
	}
	
	public function testThatNoneOwnerCannotBeSet() : Void
	{
		var tile:GameTile = new GameTile();
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
		var tile:GameTile = new GameTile();
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
		var tile:GameTile = new GameTile();
		tile.setOwner(Player.Player1);
		var exceptionThrown:Bool = false;
		
		try {
			tile.setOwner(Player.Player2);
		} catch(msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
}