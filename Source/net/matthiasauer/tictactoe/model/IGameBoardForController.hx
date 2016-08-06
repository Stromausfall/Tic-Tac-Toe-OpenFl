package net.matthiasauer.tictactoe.model;

/**
 * @author Matthias Auer
 */
interface IGameBoardForController extends IGameBoardForView
{
	/**
	 * Changes the owner of a tile on the gameboard
	 * @param	x
	 * @param	y
	 * @param	newOwner
	 */
	function changeOwner(x:Int, y:Int, newOwner:Player) : Void;
}