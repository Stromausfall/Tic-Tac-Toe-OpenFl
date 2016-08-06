package net.matthiasauer.tictactoe.model;

/**
 * @author Matthias Auer
 */
interface IGameBoardForModel extends IGameBoardForController
{
	/**
	 * Resets the tiles in the board to the starting configuration
	 */
	function resetBoard() : Void;
}