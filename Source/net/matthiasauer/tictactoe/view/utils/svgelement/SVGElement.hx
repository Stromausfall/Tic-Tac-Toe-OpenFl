package net.matthiasauer.tictactoe.view.utils.svgelement;
import format.SVG;
import net.matthiasauer.tictactoe.view.utils.element.ViewElement;
import net.matthiasauer.tictactoe.view.utils.element.data.IData;
import openfl.Assets;
import openfl.display.DisplayObject;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class SVGElement extends ViewElement
{
	private var assetName:String;
	private var shape:Shape;
	private var svg:SVG;

	public function new(assetName:String) 
	{	
		super();
		
		this.assetName = assetName;
	}
	
	override private function getDisplayObject() : DisplayObject
	{
		return this.shape;
	}
	
	public function initialize() : SVGElement
	{		
		// create the SVG
		this.svg = new SVG(Assets.getText("assets/" + this.assetName));
		this.shape = new Shape();
		
		this.svg.render(this.shape.graphics);
		
		// center the SVG
		this.shape.y = -this.shape.height / 2;
		this.shape.x = -this.shape.width / 2;
		
		// add it to the element
		this.addChild(this.shape);
		
		return this;
	}
}