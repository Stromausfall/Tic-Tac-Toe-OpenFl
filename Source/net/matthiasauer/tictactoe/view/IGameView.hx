package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponentView;
import openfl.display.DisplayObject;

/**
 * @author Matthias Auer
 */
interface IGameView extends IComponentView
{
	function getDisplayObject() : DisplayObject;
	function reset() : Void;
}