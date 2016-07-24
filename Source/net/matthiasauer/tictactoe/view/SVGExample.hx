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

		svg = new SVG(Assets.getText("assets/game_board.svg"));
		shape = new Shape();
		svg.render(shape.graphics);
		addChild(shape);
		
		// position the element
		this.shape.scaleX = 0.9;
		this.shape.scaleY = 0.9;
		this.shape.y = 20;
		
		// center the element
		this.shape.x = -this.shape.width / 2;
	}
}