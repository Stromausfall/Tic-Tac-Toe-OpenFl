package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.ComponentView;

/**
 * @author Matthias Auer
 */
interface IGameBoard extends ComponentView
{
	/**
	 * Returns the game tile at the position x,y
	 * @param	x
	 * @param	y
	 * @return
	 */
	function getTile(x:Int, y:Int) : IGameTile;
	
	/**
	 * @return the width of the game board in number of tiles
	 */
	function getHorizontalTilesCount() : Int;
	
	/**
	 * @return the height of the game board in number of tiles
	 */
	function getVerticalTilesCount() : Int;
}