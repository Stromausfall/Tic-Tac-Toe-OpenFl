package net.matthiasauer.tictactoe.controller.player;
import net.matthiasauer.tictactoe.model.IGameBoardForController;
import net.matthiasauer.tictactoe.model.Player;

/**
 * ...
 * @author Matthias Auer
 */
class Computer implements IPlayer
{
	private var id:Player;
	private var gameBoard:IGameBoardForController;
	private var observer:PlayerStatus->Void;
	
	public function new(player:Player, gameBoard:IGameBoardForController) 
	{
		this.id = player;
		this.gameBoard = gameBoard;
	}
	
	public function addObserver(observeFunction:PlayerStatus->Void) : Void
	{
		this.observer = observeFunction;
	}
	
	public function notifyTileClick(x:Int, y:Int) : Void
	{
	}
	
	public function startTurn() : Void
	{
		for (x in 0...this.gameBoard.getHorizontalTilesCount()) {
			for (y in 0...this.gameBoard.getVerticalTilesCount()) {
				if (this.gameBoard.getTile(x, y).getOwner() == Player.None) {
					this.gameBoard.changeOwner(x, y, this.id);
					this.observer(PlayerStatus.FINISHED_TURN);
					return;
				}
			}
		}
	}
}