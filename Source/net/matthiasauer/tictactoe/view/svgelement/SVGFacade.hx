package net.matthiasauer.tictactoe.view.svgelement;
import net.matthiasauer.tictactoe.model.IGameBoard;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.view.svgelement.SVGElement;
import net.matthiasauer.tictactoe.view.svgelement.data.Clickable;
import net.matthiasauer.tictactoe.view.svgelement.data.Fading;
import openfl.events.Event;

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
			case Player.Computer:
				return "circle.svg";
			case Player.Human:
				return "cross.svg";
			case Player.None:
				return "none.svg";
			default:
				throw "can't find  assetName for " + player;
		}
	}
	
	public static function createGameTile(player:Player, x:Int, y:Int) : SVGElement
	{
		// create and initialize
		var element:SVGElement = new SVGElement(getGameTileAssetName(player));
		
		if (player == Player.None)
		{
			element.addData(new Clickable<String>(x + "-" + y));
			element.addData(new Fading());
		}
		
		element.initialize();
		
		// position it
		var offset:Int = 200;
		element.x += offset * x -  offset;
		element.y += 300 + offset * y - offset;
		
		return element;
	}
}