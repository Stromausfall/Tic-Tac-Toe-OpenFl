package net.matthiasauer.tictactoe.controller.player;

/**
 * @author Matthias Auer
 */
interface IPlayer 
{
	function notifyTileClick(x:Int, y:Int) : Void;
	
	function startTurn() : Void;
	
	function addObserver(observeFunction:PlayerStatus->Void) : Void;
}