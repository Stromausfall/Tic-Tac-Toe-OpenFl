package net.matthiasauer.tictactoe.view.utils.element.data;
import net.matthiasauer.tictactoe.view.utils.element.ViewElement;
import openfl.display.DisplayObject;
import openfl.events.Event;

/**
 * ...
 * @author Matthias Auer
 */
class Fading implements IData
{
	private var fadeValueForSin:Float = 0;
	private var viewElement:ViewElement;
	private var shape:DisplayObject;
	
	public function new() 
	{
	}
	
	public function initialize(viewElement:ViewElement, shape:DisplayObject) : Void
	{
		this.viewElement = viewElement;
		this.shape = shape;
		
		// call the function every frame
		this.viewElement.addEventListener(Event.ENTER_FRAME, fade);
	}
	
	private function fade(x:Dynamic) : Void
	{
		fadeValueForSin += 0.05;
		
		if (fadeValueForSin > Math.PI)
		{
			fadeValueForSin = 0;
		}
		
		this.shape.alpha = 0.25 + Math.sin(fadeValueForSin) * 0.25;
	}
}