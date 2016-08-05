package net.matthiasauer.tictactoe.controller.player;
import haxe.unit.TestCase;
import mockatoo.Mockatoo;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.tictactoe.model.GameTile;
import net.matthiasauer.tictactoe.model.IGameBoard;
import net.matthiasauer.tictactoe.model.GameBoard;
import net.matthiasauer.tictactoe.model.Player;
using mockatoo.Mockatoo;

/**
 * ...
 * @author Matthias Auer
 */
class ComputerTest extends TestCase
{
	public function new() {
		super();
	}
	
	public function testThatComputerCallsChangeTileWhenStartTurnIsCalled()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Computer(Player.Player1, mockedGameBoard);
		player.addObserver(function(playerStatus:PlayerStatus) {});
		
		mockedGameBoard.getHorizontalTilesCount().returns(3);
		mockedGameBoard.getVerticalTilesCount().returns(3);
		mockedGameBoard.getTile(cast anyInt, cast anyInt).returns(new GameTile());
		
		// mimick a user interacting with the UI
		player.startTurn();
		
		mockedGameBoard.changeOwner(cast anyInt, cast anyInt, Player.Player1).verify();
		
		assertTrue(true);
	}
	
	public function testThatComputerCallsChangeTileWhenStartTurnIsCalledToARandomTile()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Computer(Player.Player2, mockedGameBoard);
		player.addObserver(function(playerStatus:PlayerStatus) {});
		var freeTile:GameTile = new GameTile();
		var usedTile:GameTile = new GameTile();
		usedTile.setOwner(Player.Player2);
		
		mockedGameBoard.getHorizontalTilesCount().returns(3);
		mockedGameBoard.getVerticalTilesCount().returns(3);
		mockedGameBoard.getTile(0, 0).returns(usedTile);
		mockedGameBoard.getTile(0, 1).returns(usedTile);
		mockedGameBoard.getTile(0, 2).returns(usedTile);
		mockedGameBoard.getTile(1, 0).returns(usedTile);
		mockedGameBoard.getTile(1, 1).returns(usedTile);
		mockedGameBoard.getTile(1, 2).returns(usedTile);
		mockedGameBoard.getTile(2, 0).returns(freeTile);
		mockedGameBoard.getTile(2, 1).returns(usedTile);
		mockedGameBoard.getTile(2, 2).returns(usedTile);
		
		// mimick a user interacting with the UI
		player.startTurn();
		
		mockedGameBoard.changeOwner(2, 0, Player.Player2).verify();
		
		assertTrue(true);
	}
	
	public function testThatObserverIsCalledAfterFinishingTurn()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Computer(Player.Player1, mockedGameBoard);
		var turnFinished:Bool = false;
		player.addObserver(function(playerStatus:PlayerStatus) { 
			if (playerStatus == PlayerStatus.FINISHED_TURN)
			{
				turnFinished = true;
		}});
		
		mockedGameBoard.getHorizontalTilesCount().returns(3);
		mockedGameBoard.getVerticalTilesCount().returns(3);
		mockedGameBoard.getTile(cast anyInt, cast anyInt).returns(new GameTile());
		
		// mimick a user interacting with the UI
		assertFalse(turnFinished);
		player.startTurn();
		assertTrue(turnFinished);
		
		mockedGameBoard.changeOwner(cast anyInt, cast anyInt, Player.Player1).verify();
		
		assertTrue(true);
	}
}