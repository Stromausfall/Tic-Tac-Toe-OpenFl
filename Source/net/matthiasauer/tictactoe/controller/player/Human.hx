package net.matthiasauer.tictactoe.controller.player;
import net.matthiasauer.tictactoe.model.IGameBoard;
import net.matthiasauer.tictactoe.model.Player;

/**
 * ...
 * @author Matthias Auer
 */
class Human implements IPlayer
{
	private var id:Player;
	private var gameBoard:IGameBoard;
	private var observer:PlayerStatus->Void;

	public function new(player:Player, gameBoard:IGameBoard) 
	{
		this.id = player;
		this.gameBoard = gameBoard;
	}
	
	public function notifyTileClick(x:Int, y:Int) : Void
	{
		// only change the owner if the tile isn't owned by someone yet
		if (this.gameBoard.getTile(x, y).getOwner() == Player.None)
		{
			this.gameBoard.changeOwner(x, y, this.id);
			
			this.observer(PlayerStatus.FINISHED_TURN);
		}
	}
	
	public function startTurn() : Void
	{
		
	}
	
	public function addObserver(observeFunction:PlayerStatus->Void) : Void
	{
		this.observer = observeFunction;
	}
}