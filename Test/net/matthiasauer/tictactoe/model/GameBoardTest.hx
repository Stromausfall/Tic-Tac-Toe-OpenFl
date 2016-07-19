package net.matthiasauer.tictactoe.model;
import haxe.unit.TestCase;

/**
 * ...
 * @author Matthias Auer
 */
class GameBoardTest extends TestCase
{

	public function testAllGameTilesPresent() 
	{
		var testBoard:GameBoard = new GameBoard();
		
		for (x in 0...3) {
			for (y in 0...3) {
				assertTrue(testBoard.getTile(x, y) != null);
			}
		}
	}
	
	public function testAllGameTilesAreDifferent()
	{
		var testBoard:GameBoard = new GameBoard();
		
		var lastTile:GameTile = null;
		
		for (x in 0...3) {
			for (y in 0...3) {
				var currentTile:GameTile = testBoard.getTile(x, y);
				
				// the tiles are different
				assertTrue(currentTile != lastTile);
				lastTile = currentTile;
				
				// but calling getTileTwice returns the same !
				assertEquals(currentTile, testBoard.getTile(x, y));
			}
		}
	}
	
	public function testThatOnlyValidGameTilesCanBeReturned()
	{
		var allExceptionsThrown:Bool = true;
		var correctExceptionMessageThrown:Bool = true;
		var testBoard:GameBoard = new GameBoard();
		
		for (x in [ -1, 3]) {
			for (y in [ -1, 3]) {
				try {
					testBoard.getTile(x, y);
					
					// this should not be reached
					allExceptionsThrown = true;
				} catch (msg : String) {
					// make sure the correct exception has been thrown
					if (msg != "Invalid coordinates of GameTile (" + x + "," + y + ")") {
						correctExceptionMessageThrown = false;
					}
				}
			}
		}
		
		assertTrue(allExceptionsThrown);
		assertTrue(correctExceptionMessageThrown);
	}
}