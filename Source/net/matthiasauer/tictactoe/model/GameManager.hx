package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;

/**
 * ...
 * @author Matthias Auer
 */
class GameManager implements IGameManagerForController implements IComponent
{
	private var gameStatus:GameStatus;
	private var gameBoard:IGameBoardForModel;

	public function new() 
	{
		this.gameStatus = GameStatus.MENU;
	}

	public function initializeComponent(system:ISystem) : Void
	{
		this.gameBoard = system.get(IGameBoardForModel);
	}
	
	public function getStatus() : GameStatus
	{
		return this.gameStatus;
	}
	
	public function startGame() : Void
	{
		this.gameStatus = GameStatus.GAME;
		this.gameBoard.resetBoard();
	}
}