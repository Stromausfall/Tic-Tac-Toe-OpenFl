package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.observer.SimpleObservable;

/**
 * ...
 * @author Matthias Auer
 */
class GameManager implements IGameManagerForController implements IComponent
{
	private var observable:SimpleObservable;
	private var gameStatus:GameStatus;
	private var gameBoard:IGameBoardForModel;

	public function new() 
	{
		this.gameStatus = GameStatus.MENU;
		this.observable = new SimpleObservable();
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
		this.changeStatus(GameStatus.GAME);
		
		this.gameBoard.resetBoard();
	}
	
	private function changeStatus(gameStatus:GameStatus) : Void
	{
		this.gameStatus = gameStatus;
		this.observable.notify();
	}
	
	public function addObserver(observeFunction:Void->Void) : Void
	{
		this.observable.add("mainObserver", observeFunction);
	}
}