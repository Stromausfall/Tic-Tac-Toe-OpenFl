package net.matthiasauer.tictactoe.view.svgelement.data;
import format.SVG;
import openfl.display.Shape;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Matthias Auer
 */
class Clickable<T> implements IData
{
	private var identifier:T;
	
	public function new(identifier:T) 
	{
		this.identifier = identifier;
	}
	
	public function initialize(svgElement:SVGElement, shape:Shape, svg:SVG) : Void
	{
		// make clickable
		svgElement.addEventListener(MouseEvent.CLICK, this.click);
	}
	
	private function click(e:Dynamic) : Void
	{
		trace("clicked: " + this.identifier);
	}
}
