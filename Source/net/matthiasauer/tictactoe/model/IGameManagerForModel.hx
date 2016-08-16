package net.matthiasauer.tictactoe.model;

/**
 * @author Matthias Auer
 */
interface IGameManagerForModel extends IGameManagerForController
{
	function gameIsOver(winner:Player) : Void;
}