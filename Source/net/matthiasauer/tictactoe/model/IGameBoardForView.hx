package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponentView;

/**
 * @author Matthias Auer
 */
interface IGameBoardForView extends IComponentView
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