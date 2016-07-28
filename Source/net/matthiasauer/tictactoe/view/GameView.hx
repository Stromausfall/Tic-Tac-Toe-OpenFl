package net.matthiasauer.tictactoe.view;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class GameView extends Sprite
{

	public function new() 
	{
		
	}

	
	public function setUp()
	{	
		this.addChild(SVGFacade.createGameBoard());
	}
}