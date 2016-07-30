package net.matthiasauer.tictactoe.view.svgelement.data;
import format.SVG;
import openfl.display.Shape;
import openfl.events.Event;

/**
 * ...
 * @author Matthias Auer
 */
class Fading implements IData
{
	private var fadeValueForSin:Float = 0;
	private var svgElement:SVGElement;
	private var shape:Shape;
	
	public function new() 
	{
	}
	
	public function initialize(svgElement:SVGElement, shape:Shape, svg:SVG) : Void
	{
		this.svgElement = svgElement;
		this.shape = shape;
		
		// call the function every frame
		this.svgElement.addEventListener(Event.ENTER_FRAME, fade);
	}
	
	private function fade(x:Dynamic) : Void
	{
		fadeValueForSin += 0.05;
		
		if (fadeValueForSin > Math.PI)
		{
			fadeValueForSin = 0;
		}
		
		shape.alpha = 0.25 + Math.sin(fadeValueForSin) * 0.25;
	}
}