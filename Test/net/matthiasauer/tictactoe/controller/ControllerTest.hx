package net.matthiasauer.tictactoe.controller;
import haxe.unit.TestCase;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.tictactoe.model.GameBoard;
import mockatoo.Mockatoo.*;
import net.matthiasauer.tictactoe.model.GameTile;
import net.matthiasauer.tictactoe.model.IGameBoard;
import net.matthiasauer.tictactoe.model.IGameTile;
import net.matthiasauer.tictactoe.model.Player;
using mockatoo.Mockatoo;

/**
 * ...
 * @author Matthias Auer
 */
class ControllerTest extends TestCase
{
	public function getIControllerFromSetup(mockedGameBoard:GameBoard) : IController
	{
		var system:SystemForMocks = new SystemForMocks();
		system.register(GameBoard, [IGameBoard]);
		system.registerMock(GameBoard, mockedGameBoard);		
		system.register(Controller, [IController]);
		
		return system.get(IController);
	}
	
	public function testGetHorizontalTilesCount() 
	{
		var mockedGameBoard:GameBoard = mock(GameBoard);
		var controller:IController = getIControllerFromSetup(mockedGameBoard);
		
		mockedGameBoard.getHorizontalTilesCount().returns(44);
		var retrievedHorizontalTilesCount = controller.getHorizontalTilesCount();
		
		assertEquals(44, retrievedHorizontalTilesCount);
	}
	
	public function testGetVerticalTilesCount() 
	{
		var mockedGameBoard:GameBoard = mock(GameBoard);
		var controller:IController = getIControllerFromSetup(mockedGameBoard);
		
		mockedGameBoard.getVerticalTilesCount().returns(43);
		var retrievedVerticalTilesCount = controller.getVerticalTilesCount();
		
		assertEquals(43, retrievedVerticalTilesCount);
	}
	
	public function testGetTileOwner()
	{
		var mockedGameBoard:GameBoard = mock(GameBoard);
		var controller:IController = getIControllerFromSetup(mockedGameBoard);
		var owner:Player = Player.Computer;
		
		// define what should be returned from the GameBoard
		var tileToReturn:GameTile = new GameTile(2, 1);
		tileToReturn.setOwner(owner);
		mockedGameBoard.getTile(2, 1).returns(tileToReturn);
		
		var retrievedOwner = controller.getTileOwner(2, 1);
		
		assertEquals(owner, retrievedOwner);
	}
}