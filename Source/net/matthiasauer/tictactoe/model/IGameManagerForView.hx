package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponentView;

/**
 * @author Matthias Auer
 */
interface IGameManagerForView extends IComponentView
{
	function getStatus() : GameStatus;
}