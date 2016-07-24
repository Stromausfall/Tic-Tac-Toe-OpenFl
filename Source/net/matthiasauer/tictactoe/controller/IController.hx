package net.matthiasauer.tictactoe.controller;
import net.matthiasauer.di.ComponentView;

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
}