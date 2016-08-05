package net.matthiasauer.tictactoe.view.element.data;
import net.matthiasauer.tictactoe.view.element.ViewElement;
import openfl.display.DisplayObject;

/**
 * @author Matthias Auer
 */
interface IData
{
	function initialize(svgElement:ViewElement, displayObject:DisplayObject) : Void;
}