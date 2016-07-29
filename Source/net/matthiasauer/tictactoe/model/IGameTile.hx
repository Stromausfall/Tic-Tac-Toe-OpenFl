package net.matthiasauer.tictactoe.model;

/**
 * @author Matthias Auer
 */
interface IGameTile 
{
	function getOwner() : Player;
	function addObserver(observer:Void->Void) : Void;
}