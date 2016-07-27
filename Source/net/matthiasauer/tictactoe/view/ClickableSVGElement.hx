package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.ISystem;
import openfl.events.MouseEvent;

/**
 * ...
 * @author Matthias Auer
 */
@:generic
class ClickableSVGElement<T> extends SVGElement
{
	private var identifier:T;
	
	public function new(assetName:String, identifier:T) 
	{
		super(assetName);
		
		this.identifier = identifier;
	}
	
	public override function initialize() : SVGElement
	{
		super.initialize();
				
		// make clickable
		this.addEventListener(MouseEvent.CLICK, this.click);
		
		return this;
	}
	
	private function click(e:Dynamic) : Void
	{
		trace("clicked: " + this.identifier);
	}
}