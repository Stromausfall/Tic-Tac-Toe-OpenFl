package net.matthiasauer.tictactoe.controller;
import haxe.unit.TestCase;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.tictactoe.model.GameStatus;
import net.matthiasauer.tictactoe.model.GameManager;
import net.matthiasauer.tictactoe.model.GameBoard;
import net.matthiasauer.tictactoe.model.IGameBoardForModel;
import net.matthiasauer.tictactoe.model.IGameManagerForController;
import net.matthiasauer.tictactoe.controller.player.IPlayer;
import mockatoo.Mockatoo.*;
import net.matthiasauer.tictactoe.controller.player.PlayerStatus;
using mockatoo.Mockatoo;

/**
 * @author Matthias Auer
 */
class ControllerTest extends TestCase
{
	public function new() {
		super();
	}
	
	private function createMockedSystem() : ISystem
	{
		var mockedGameManager:GameManager = mock(GameManager);
		mockedGameManager.isGameOver().returns(false);
		
		var mockSystem:SystemForMocks = new SystemForMocks();
		mockSystem.register(GameManager, [IGameManagerForController]);
		mockSystem.registerMock(GameManager, mockedGameManager);
		
		return mockSystem;
	}
	
	public function testThatObserverNotifcationsAreForwardedToThePlayerController()
	{		
		var controller:Controller = new Controller();
		var mockPlayer1:IPlayer = Mockatoo.mock(IPlayer);
		var mockPlayer2:IPlayer = Mockatoo.mock(IPlayer);
		controller.initializeComponent(this.createMockedSystem());
		controller.setPlayers(mockPlayer1, mockPlayer2);
		
		var x:Int = 1;
		var y:Int = 0;
		controller.notifyTileClick(x, y);
		
		// check that the mock has been called
		mockPlayer1.notifyTileClick(x, y).verify(1);
		
		assertTrue(true);
	}
	
	public function testThatControllerAddsItselfAsObserverToPlayers()
	{
		var controller:IController = new Controller();
		var mockPlayer1:IPlayer = Mockatoo.mock(IPlayer);
		var mockPlayer2:IPlayer = Mockatoo.mock(IPlayer);
		controller.setPlayers(mockPlayer1, mockPlayer2);
		
		// check that the mock has been called
		mockPlayer1.addObserver(cast any).verify(1);
		mockPlayer2.addObserver(cast any).verify(1);
		
		assertTrue(true);
	}
	
	public function testThatStartGameCallsStartTurnOnPlayer1()
	{
		var controller:IController = new Controller();
		var mockPlayer1:IPlayer = Mockatoo.mock(IPlayer);
		var mockPlayer2:IPlayer = Mockatoo.mock(IPlayer);
		controller.setPlayers(mockPlayer1, mockPlayer2);
		
		controller.startGame();
		
		// check that the mock has been called
		mockPlayer1.startTurn().verify(1);
		mockPlayer2.startTurn().verify(0);
		
		assertTrue(true);
	}
	
	public function testThatIPlayerCanInformTheControllerThatItHasFinishedItsTurn()
	{
		var controller:Controller = new Controller();
		var player1:TestIPlayer = new TestIPlayer();
		var player2:TestIPlayer = new TestIPlayer();
		controller.initializeComponent(this.createMockedSystem());
		controller.setPlayers(player1, player2);
		
		controller.startGame();
		
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		
		// check that the mock has been called
		assertEquals(1, player1.startTurnCalled);
		assertEquals(1, player2.startTurnCalled);
	}
	
	public function testThatIPlayerCanInformTheControllerThatItHasFinishedItsTurnMultipleTurns()
	{
		var controller:Controller = new Controller();
		var player1:TestIPlayer = new TestIPlayer();
		var player2:TestIPlayer = new TestIPlayer();
		controller.initializeComponent(this.createMockedSystem());
		controller.setPlayers(player1, player2);
		
		controller.startGame();
		
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		player2.observeFunction(PlayerStatus.FINISHED_TURN);
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		player2.observeFunction(PlayerStatus.FINISHED_TURN);
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		
		// check that the mock has been called
		assertEquals(3, player1.startTurnCalled);
		assertEquals(3, player2.startTurnCalled);
	}
	
	public function testThatClickingOnTheNewGameMenuButtonChangesTheGameState()
	{
		var system:SystemForMocks = new SystemForMocks();
		system.register(Controller, [IController]);
		system.register(GameManager, [IGameManagerForController]);
		system.register(GameBoard, [IGameBoardForModel]);
		system.registerMock(GameBoard, mock(GameBoard));
		
		var controller:IController = system.get(IController);
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		var player1:TestIPlayer = new TestIPlayer();
		var player2:TestIPlayer = new TestIPlayer();
		controller.setPlayers(player1, player2);
		
		assertEquals(GameStatus.MENU, gameManager.getStatus());
		
		controller.notifyNewGameClick();
		
		assertEquals(GameStatus.GAME, gameManager.getStatus());
	}
	
	public function testThatIfGameIsOverNoPlayerIsTriggeredAnymore()
	{
		var controller:Controller = new Controller();
		var player1:TestIPlayer = new TestIPlayer();
		var player2:TestIPlayer = new TestIPlayer();
		
		var mockedGameManager:GameManager = mock(GameManager);
		mockedGameManager.isGameOver().returns(true);
		
		var mockSystem:SystemForMocks = new SystemForMocks();
		mockSystem.register(GameManager, [IGameManagerForController]);
		mockSystem.registerMock(GameManager, mockedGameManager);
		
		controller.initializeComponent(mockSystem);
		controller.setPlayers(player1, player2);
		
		controller.startGame();		
		
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		player2.observeFunction(PlayerStatus.FINISHED_TURN);
		player1.observeFunction(PlayerStatus.FINISHED_TURN);
		player2.observeFunction(PlayerStatus.FINISHED_TURN);
		
		// check that the mock has been called
		assertEquals(0, player2.startTurnCalled);
	}
}

class TestIPlayer implements IPlayer
{
	public var observeFunction:PlayerStatus->Void;
	public var startTurnCalled:Int = 0;
	
	public function new()
	{
		
	}
	
	public function startTurn() : Void
	{
		this.startTurnCalled += 1;
	}
	
	public function notifyTileClick(x:Int, y:Int) : Void
	{
	}
	
	public function addObserver(observeFunction:PlayerStatus->Void) : Void
	{
		this.observeFunction = observeFunction;
	}
}
