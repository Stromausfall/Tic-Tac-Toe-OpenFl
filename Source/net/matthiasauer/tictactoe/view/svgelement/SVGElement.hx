package net.matthiasauer.tictactoe.view.svgelement;
import format.SVG;
import net.matthiasauer.tictactoe.view.svgelement.data.IData;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class SVGElement extends Sprite
{
	private var assetName:String;
	private var shape:Shape;
	private var svg:SVG;
	private var data:Array<IData>;

	public function new(assetName:String) 
	{
		super();
		
		this.assetName = assetName;
		this.data = new Array<IData>();
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
		
		// initialize the data elements (these can add extra functionality)
		for (dataElement in this.data)
		{
			dataElement.initialize(this, this.shape, this.svg);
		}
		
		return this;
	}
	
	public function addData(dataElement : IData)
	{
		this.data.push(dataElement);
	}
}