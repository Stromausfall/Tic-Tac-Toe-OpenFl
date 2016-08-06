package net.matthiasauer.tictactoe.model;

/**
 * @author Matthias Auer
 */
interface IGameManagerForController extends IGameManagerForView
{
	function startGame() : Void;
}