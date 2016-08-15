package net.matthiasauer.tictactoe.model;
import haxe.unit.TestCase;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;

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
		
		var lastTile:IGameTile = null;
		
		for (x in 0...3) {
			for (y in 0...3) {
				var currentTile:IGameTile = testBoard.getTile(x, y);
				
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
	
	public function testGetHorizontalTilesCount() {
		var testBoard:IGameBoardForView = new GameBoard();
		
		// it should be hardcoded to 3
		assertEquals(3, testBoard.getHorizontalTilesCount());
	}
	
	public function testGetVerticalTilesCount() {
		var testBoard:IGameBoardForView = new GameBoard();
		
		// it should be hardcoded to 3
		assertEquals(3, testBoard.getVerticalTilesCount());
	}
	
	public function testThatChangingOwnerIsCorrect() {
		var testBoard:IGameBoardForController = new GameBoard();
		
		// first test that all tiles are correctly initialized
		for (x in 0...3) {
			for (y in 0...3) {
				var owner:Player = testBoard.getTile(x, y).getOwner();
				
				assertEquals(Player.None, owner);
			}
		}
		
		// now change a tile
		testBoard.changeOwner(2, 1, Player.Player2);
		var nonePlayerOwnedTiles:Int = 0;
		
		for (x in 0...3) {
			for (y in 0...3) {
				if (testBoard.getTile(x, y).getOwner() == Player.None) {
					nonePlayerOwnedTiles += 1;
				}
			}
		}
		
		// make sure only one was changed
		assertEquals(8, nonePlayerOwnedTiles);
		
		// make sure the correct tile has changed to the correct value
		assertEquals(Player.Player2, testBoard.getTile(2, 1).getOwner());
	}
	
	public function testThatChangingTheOwnerNotifiesListenersOfTheTile() {
		var testBoard:IGameBoardForController = new GameBoard();
		var notified:Bool = false;
		
		// add an observer
		testBoard.getTile(2, 1).addObserver(function() { notified = true; });
		
		assertFalse(notified);
		
		testBoard.changeOwner(2, 1, Player.Player2);
		
		// expect that the observer was triggered
		assertTrue(notified);
	}
	
	public function testResetBoardResetsOwners() {
		var testBoard:IGameBoardForModel = new GameBoard();
		
		testBoard.changeOwner(2, 0, Player.Player1);
		testBoard.changeOwner(1, 1, Player.Player2);
		testBoard.changeOwner(0, 2, Player.Player1);
		
		testBoard.resetBoard();
		
		assertEquals(Player.None, testBoard.getTile(2, 0).getOwner());
		assertEquals(Player.None, testBoard.getTile(1, 1).getOwner());
		assertEquals(Player.None, testBoard.getTile(0, 2).getOwner());
	}
	
	public function testThatHorizontalLinesWinsGame() {
		for (player in [Player.Player1, Player.Player2]) {
			for (y in 0...3) {
				var system:ISystem = new System();
				
				system.register(GameBoard, [IGameBoardForModel]);
				system.register(GameManager, [IGameManagerForModel]);
				
				var testBoard:IGameBoardForModel = system.get(IGameBoardForModel);
				var gameManager:IGameManagerForModel = system.get(IGameManagerForModel);
				
				testBoard.resetBoard();
				testBoard.changeOwner(0, y, player);
				testBoard.changeOwner(1, y, player);
				
				assertFalse(gameManager.isGameOver());
				
				testBoard.changeOwner(2, y, player);
				
				assertTrue(gameManager.isGameOver());
			}
		}
	}
	
	public function testThatVerticalLinesWinsGame() {
		for (player in [Player.Player1, Player.Player2]) {
			for (x in 0...3) {
				var system:ISystem = new System();
				
				system.register(GameBoard, [IGameBoardForModel]);
				system.register(GameManager, [IGameManagerForModel]);
				
				var testBoard:IGameBoardForModel = system.get(IGameBoardForModel);
				var gameManager:IGameManagerForModel = system.get(IGameManagerForModel);
				
				testBoard.resetBoard();
				testBoard.changeOwner(x, 0, player);
				testBoard.changeOwner(x, 1, player);
				
				assertFalse(gameManager.isGameOver());
				
				testBoard.changeOwner(x, 2, player);
				
				assertTrue(gameManager.isGameOver());
			}
		}
	}
	
	public function testThatDiagonalLine1WinsGame() {
		for (player in [Player.Player1, Player.Player2]) {
			var system:ISystem = new System();
					
			system.register(GameBoard, [IGameBoardForModel]);
			system.register(GameManager, [IGameManagerForModel]);
					
			var testBoard:IGameBoardForModel = system.get(IGameBoardForModel);
			var gameManager:IGameManagerForModel = system.get(IGameManagerForModel);
					
			testBoard.resetBoard();
			testBoard.changeOwner(2, 0, player);
			testBoard.changeOwner(1, 1, player);
					
			assertFalse(gameManager.isGameOver());
					
			testBoard.changeOwner(0, 2, player);
					
			assertTrue(gameManager.isGameOver());
		}
	}
	
	public function testThatDiagonalLine2WinsGame() {
		for (player in [Player.Player1, Player.Player2]) {
			var system:ISystem = new System();
					
			system.register(GameBoard, [IGameBoardForModel]);
			system.register(GameManager, [IGameManagerForModel]);
					
			var testBoard:IGameBoardForModel = system.get(IGameBoardForModel);
			var gameManager:IGameManagerForModel = system.get(IGameManagerForModel);
					
			testBoard.resetBoard();
			testBoard.changeOwner(0, 0, player);
			testBoard.changeOwner(1, 1, player);
					
			assertFalse(gameManager.isGameOver());
					
			testBoard.changeOwner(2, 2, player);
					
			assertTrue(gameManager.isGameOver());
		}
	}
}