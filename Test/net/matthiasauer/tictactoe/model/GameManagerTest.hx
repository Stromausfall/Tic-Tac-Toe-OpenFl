package net.matthiasauer.tictactoe.model;
import haxe.unit.TestCase;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;
import mockatoo.Mockatoo.*;
import net.matthiasauer.di.SystemForMocks;
using mockatoo.Mockatoo;

/**
 * ...
 * @author Matthias Auer
 */
class GameManagerTest extends TestCase
{

	public function new() 
	{
		super();
	}
	
	private function setupSystem() : ISystem
	{
		var system:SystemForMocks = new SystemForMocks();
		
		system.register(GameManager, [IGameManagerForModel, IGameManagerForController]);		
		system.register(GameBoard, [IGameBoardForController, IGameBoardForView, IGameBoardForModel]);
		
		return system;
	}
	
	public function testThatGameManagerExists()
	{
		var system:ISystem = this.setupSystem();		
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		
		assertTrue(gameManager != null);
	}
	
	public function testThatInitialStatusIsMenu()
	{
		var system:ISystem = this.setupSystem();
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		
		assertTrue(gameManager.getStatus() == GameStatus.MENU);
	}
	
	public function testThatStartGameChangesStatus()
	{
		var system:ISystem = this.setupSystem();
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		
		gameManager.startGame();
		
		assertTrue(gameManager.getStatus() == GameStatus.GAME);
	}
	
	public function testThatStartGameRevertsGameBoard()
	{
		var system:ISystem = this.setupSystem();		
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);	
		var gameBoard:IGameBoardForController = system.get(IGameBoardForController);
		
		gameBoard.changeOwner(2, 0, Player.Player1);
		gameBoard.changeOwner(1, 1, Player.Player2);
		gameBoard.changeOwner(0, 2, Player.Player1);
		
		gameManager.startGame();
		
		assertEquals(Player.None, gameBoard.getTile(2, 0).getOwner());
		assertEquals(Player.None, gameBoard.getTile(1, 1).getOwner());
		assertEquals(Player.None, gameBoard.getTile(0, 2).getOwner());
	}
	
	public function testThatGameStatusChangeNotifiesObservers()
	{
		var system:ISystem = this.setupSystem();		
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		var notified:Bool = false;
		
		gameManager.addObserver(function() { notified = true; });
		
		assertFalse(notified);
		gameManager.startGame();
		assertTrue(notified);
	}
	
	public function testThatGameStatusCanBeChangedToMenu()
	{
		var system:ISystem = this.setupSystem();
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		
		assertEquals(GameStatus.MENU, gameManager.getStatus());
		gameManager.startGame();
		assertEquals(GameStatus.GAME, gameManager.getStatus());
		gameManager.goToMenu();
		assertEquals(GameStatus.MENU, gameManager.getStatus());
	}
	
	public function testThatGameStatusChangeToMenuNotifiesObservers()
	{
		var system:ISystem = this.setupSystem();
		var gameManager:IGameManagerForController = system.get(IGameManagerForController);
		var notified:Bool = false;
		
		gameManager.addObserver(function() { notified = true; });
		
		gameManager.startGame();
		notified = false;
		gameManager.goToMenu();
		assertTrue(notified);
	}
}