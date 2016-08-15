package net.matthiasauer.tictactoe.view.utils.element.data;
import net.matthiasauer.tictactoe.view.utils.element.ViewElement;
import openfl.display.DisplayObject;

/**
 * @author Matthias Auer
 */
interface IData
{
	function initialize(svgElement:ViewElement, displayObject:DisplayObject) : Void;
}