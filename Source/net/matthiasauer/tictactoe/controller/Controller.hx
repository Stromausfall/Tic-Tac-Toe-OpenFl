package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.tictactoe.controller.player.IPlayer;
import net.matthiasauer.tictactoe.controller.player.PlayerStatus;

/**
 * ...
 * @author Matthias Auer
 */
class Controller implements IController
{
	private var activePlayer:IPlayer = null;
	private var inactivePlayer:IPlayer = null;

	public function new()
	{
	}
	
	public function notifyTileClick(x:Int, y:Int) : Void
	{
		this.activePlayer.notifyTileClick(x, y);
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
				
				if (playerStatus == PlayerStatus.FINISHED_TURN)
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
}