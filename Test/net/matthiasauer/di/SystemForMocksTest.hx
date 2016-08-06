package net.matthiasauer.di;
import haxe.unit.TestCase;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.tictactoe.model.GameBoard;
import mockatoo.Mockatoo.*;
import net.matthiasauer.tictactoe.model.IGameBoardForView;
using mockatoo.Mockatoo;

/**
 * ...
 * @author Matthias Auer
 */
class SystemForMocksTest extends TestCase
{
	public function testSystemForMocks() 
	{
		var system:SystemForMocks = new SystemForMocks();
		var mockedGameBoard:GameBoard = mock(GameBoard);
		system.register(GameBoard, [IGameBoardForView]);
		system.registerMock(GameBoard, mockedGameBoard);
		
		var mocked:Dynamic = mockedGameBoard;
		var retrievedIGameBoard:Dynamic = system.get(IGameBoardForView);
		
		assertEquals(mocked, retrievedIGameBoard);
	}
	
}