package net.matthiasauer.tictactoe.view;
import format.SVG;
import openfl.Assets;
import openfl.display.Shape;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class SVGExample extends Sprite
{
	var svg:SVG;
	var shape:Shape;

	public function new()
	{
		super();

		svg = new SVG(Assets.getText("assets/awesome_tiger.svg"));
		shape = new Shape();
		svg.render(shape.graphics);
		addChild(shape);
	}
}