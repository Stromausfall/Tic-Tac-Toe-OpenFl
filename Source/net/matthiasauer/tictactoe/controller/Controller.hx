package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.controller.player.IPlayer;
import net.matthiasauer.tictactoe.controller.player.PlayerStatus;
import net.matthiasauer.tictactoe.model.IGameManagerForController;

/**
 * ...
 * @author Matthias Auer
 */
class Controller implements IController implements IComponent
{
	private var activePlayer:IPlayer = null;
	private var inactivePlayer:IPlayer = null;
	private var gameManager:IGameManagerForController = null;

	public function new()
	{
	}
	
	public function notifyTileClick(x:Int, y:Int) : Void
	{
		if (this.gameManager.isGameOver() == false) {
			this.activePlayer.notifyTileClick(x, y);
		}
	}
	
	public function setPlayers(player1:IPlayer, player2:IPlayer) : Void
	{
		this.activePlayer = player1;
		this.inactivePlayer = player2;
		
		this.addObserverToPlayer(this.activePlayer);
		this.addObserverToPlayer(this.inactivePlayer);
	}
	
	private function addObserverToPlayer(player:IPlayer)
	{
		player.addObserver(
			function(playerStatus:PlayerStatus)
			{
				if (this.activePlayer != player) 
				{
					// the notification is from the inactive player !
					// --> do nothing
					return;
				}
				
				if ((playerStatus == PlayerStatus.FINISHED_TURN) && (this.gameManager.isGameOver() == false))
				{
					// change the active and inactive player
					this.activePlayer = this.inactivePlayer;
					this.inactivePlayer = player;
					
					// finally call the next turn
					this.activePlayer.startTurn();
				}
			});
	}
	
	public function startGame() : Void 
	{
		this.activePlayer.startTurn();
	}
	
	public function notifyNewGameClick() : Void
	{
		this.gameManager.startGame();
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameManager = system.get(IGameManagerForController);
	}
}