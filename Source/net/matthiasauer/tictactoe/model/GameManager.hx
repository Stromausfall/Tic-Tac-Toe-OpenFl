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
	private var winner:Player;
	private var observable:SimpleObservable;
	private var gameOverObservable:SimpleObservable;
	private var gameStatus:GameStatus;
	private var gameBoard:IGameBoardForModel;

	public function new() 
	{
		this.winner = null;
		this.gameStatus = GameStatus.MENU;
		this.observable = new SimpleObservable();
		this.gameOverObservable = new SimpleObservable();
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
	
	public function goToMenu() : Void
	{
		this.changeStatus(GameStatus.MENU);
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
	
	public function addGameOverObserver(observeFunction:Void->Void) : Void
	{
		this.gameOverObservable.add("mainObserver", observeFunction);
	}
	
	public function isGameOver() : Bool
	{
		return this.winner != null;
	}
	
	public function gameIsOver(winner:Player) : Void
	{
		this.winner = winner;
		this.gameOverObservable.notify();
	}
	
	public function getWinner() : Player
	{
		return this.winner;
	}
}