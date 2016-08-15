package net.matthiasauer.tictactoe.view.utils.element;
import net.matthiasauer.tictactoe.view.utils.element.data.IData;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class ViewElement extends Sprite
{
	private var data:Array<IData>;
	
	private function new() 
	{
		super();
		
		this.data = new Array<IData>();
	}
	
	private function getDisplayObject() : DisplayObject
	{
		// implement in sub class
		return null;
	}
	
	public function addData(dataElement : IData) : ViewElement
	{
		// add the element
		this.data.push(dataElement);
		
		// initialize it
		dataElement.initialize(this, this.getDisplayObject());
		
		return this;
	}
}