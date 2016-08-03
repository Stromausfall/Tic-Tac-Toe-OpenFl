package net.matthiasauer.tictactoe.view.svgelement.data;
import format.SVG;
import openfl.display.Shape;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Matthias Auer
 */
class Clickable implements IData
{
	private var clickFunction:Void->Void;
	
	public function new(clickFunction:Void->Void) 
	{
		this.clickFunction = clickFunction;
	}
	
	public function initialize(svgElement:SVGElement, shape:Shape, svg:SVG) : Void
	{
		// make clickable
		svgElement.addEventListener(MouseEvent.CLICK, this.click);
	}
	
	private function click(e:Dynamic) : Void
	{
		this.clickFunction();
	}
}
