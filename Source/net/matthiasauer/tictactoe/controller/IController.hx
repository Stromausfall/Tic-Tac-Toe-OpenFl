package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.di.IComponentView;
import net.matthiasauer.tictactoe.controller.player.IPlayer;

/**
 * ...
 * @author Matthias Auer
 */
interface IController extends IComponentView
{
	function notifyTileClick(x:Int, y:Int) : Void;
	
	function setPlayers(player1:IPlayer, player2:IPlayer) : Void;
	
	function startGame() : Void;
	
	function notifyNewGameClick() : Void;
}