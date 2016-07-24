package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.di.ComponentView;
import net.matthiasauer.tictactoe.model.Player;

/**
 * @author Matthias Auer
 */
interface IController extends ComponentView
{
	/**
	 * @return the number of tiles horizontally in the game board
	 */
	function getHorizontalTilesCount() : Int;
	
	/**
	 * @return the number of tiles vertically in the game board
	 */
	function getVerticalTilesCount() : Int;
	
	/**
	 * Returns the owner of the tile at the position
	 * @param	x defines the position of the tile
	 * @param	y defines the position of the tile
	 * @return the owner of the tile at the given position
	 */
	function getTileOwner(x:Int, y:Int) : Player;
}