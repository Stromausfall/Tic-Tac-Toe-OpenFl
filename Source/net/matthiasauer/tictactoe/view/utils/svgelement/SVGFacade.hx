package net.matthiasauer.tictactoe.view.utils.svgelement;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.view.utils.element.data.Clickable;
import net.matthiasauer.tictactoe.view.utils.element.data.Fading;
import net.matthiasauer.tictactoe.view.utils.svgelement.SVGElement;

/**
 * ...
 * @author Matthias Auer
 */
class SVGFacade
{
	private function new() 
	{
	}
	
	public static function createGameBoard() : SVGElement 
	{
		// create and initialize
		var element:SVGElement = new SVGElement("game_board.svg").initialize();

		// position it
		element.y += element.height / 2;
		
		return element;
	}
	
	private static function getGameTileAssetName(player:Player) : String 
	{
		switch(player) {
			case Player.Player2:
				return "circle.svg";
			case Player.Player1:
				return "cross.svg";
			case Player.None:
				return "none.svg";
			default:
				throw "can't find assetName for " + player;
		}
	}
	
	public static function createGameTile(player:Player, x:Int, y:Int, controller:IController) : SVGElement
	{
		// create and initialize
		var element:SVGElement = new SVGElement(getGameTileAssetName(player));
		
		element.initialize();
		
		if (player == Player.None)
		{
			element.addData(new Clickable(function() { controller.notifyTileClick(x, y); }));
			element.addData(new Fading());
		}
		
		// position it
		var offset:Int = 200;
		element.x += offset * x -  offset;
		element.y += 300 + offset * y - offset;
		
		return element;
	}
}