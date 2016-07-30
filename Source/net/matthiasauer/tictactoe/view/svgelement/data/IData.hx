package net.matthiasauer.tictactoe.view.svgelement.data;
import format.SVG;
import openfl.display.Shape;

/**
 * @author Matthias Auer
 */
interface IData 
{
	function initialize(svgElement:SVGElement, shape:Shape, svg:SVG) : Void;
}