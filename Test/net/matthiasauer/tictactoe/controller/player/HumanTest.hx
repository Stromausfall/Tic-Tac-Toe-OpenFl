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
class HumanTest extends TestCase
{
	public function new() {
		super();
	}
	
	public function testThatClickingValidTileForwardsTheCallToTheModel()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Human(Player.Player1, mockedGameBoard);
		
		mockedGameBoard.getTile(1, 2).returns(new GameTile(1, 2));
		
		// mimick a user interacting with the UI
		player.notifyTileClick(1, 2);
		
		mockedGameBoard.changeOwner(1, 2, Player.Player1).verify();
		
		assertTrue(true);
	}
	
	public function testThatClickingInvalidTileDoesntForwardTheCallToTheModel()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Human(Player.Player1, mockedGameBoard);
		var alreadyOccupiedTile = new GameTile(1, 2);
		alreadyOccupiedTile.setOwner(Player.Player1);
		
		mockedGameBoard.getTile(1, 2).returns(alreadyOccupiedTile);
		
		// mimick a user interacting with the UI
		player.notifyTileClick(1, 2);
		
		mockedGameBoard.changeOwner(1, 2, Player.Player1).verify(0);
		
		assertTrue(true);
	}
	
	public function testThatClickingInvalidTileDoesntForwardTheCallToTheModel2()
	{
		var mockedGameBoard:GameBoard = Mockatoo.mock(GameBoard);
		var player:IPlayer = new Human(Player.Player1, mockedGameBoard);
		var alreadyOccupiedTile = new GameTile(1, 2);
		alreadyOccupiedTile.setOwner(Player.Player2);
		
		mockedGameBoard.getTile(1, 2).returns(alreadyOccupiedTile);
		
		// mimick a user interacting with the UI
		player.notifyTileClick(1, 2);
		
		mockedGameBoard.changeOwner(1, 2, Player.Player1).verify(0);
		
		assertTrue(true);
	}
}