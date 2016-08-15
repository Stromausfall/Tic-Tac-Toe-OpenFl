package net.matthiasauer.tictactoe.view.utils.view;
import openfl.display.DisplayObject;

/**
 * @author Matthias Auer
 */
interface IView 
{
	function getDisplayObject() : DisplayObject;
	function reset() : Void;
}