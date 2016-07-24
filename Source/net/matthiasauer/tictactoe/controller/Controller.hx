package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.model.IGameBoard;
import net.matthiasauer.tictactoe.model.Player;

/**
 * ...
 * @author Matthias Auer
 */
class Controller implements Component implements IController
{
	private var gameBoard:IGameBoard;
	
	public function new() 
	{
		
	}
	
	public function getHorizontalTilesCount() : Int 
	{
		return this.gameBoard.getHorizontalTilesCount();
	}
	
	public function getVerticalTilesCount() : Int
	{
		return this.gameBoard.getVerticalTilesCount();
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameBoard = system.get(IGameBoard);
	}
	
	public function getTileOwner(x:Int, y:Int) : Player
	{
		return this.gameBoard.getTile(x, y).getOwner();
	}
}