package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponentView;

/**
 * @author Matthias Auer
 */
interface IGameManagerForView extends IComponentView
{
	function isGameOver() : Bool;
	function getWinner() : Player;
	function getStatus() : GameStatus;
	function addObserver(observeFunction:Void->Void) : Void;
}