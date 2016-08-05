package net.matthiasauer.tictactoe.view.element.data;
import openfl.display.DisplayObject;
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
	
	public function initialize(viewElement:ViewElement, shape:DisplayObject) : Void
	{
		// make clickable
		viewElement.addEventListener(MouseEvent.CLICK, this.click);
	}
	
	private function click(e:Dynamic) : Void
	{
		this.clickFunction();
	}
}
