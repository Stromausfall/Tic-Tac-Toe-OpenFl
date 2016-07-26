package net.matthiasauer.tictactoe.view;
import net.matthiasauer.tictactoe.model.Player;
import openfl.events.MouseEvent;

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
			default:
				throw "can't find  assetName for " + player;
		}
	}
	
	public static function createGameTile(player:Player, x:Int, y:Int) : SVGElement
	{
		// create and initialize
		var element:SVGElement = new SVGElement(getGameTileAssetName(player)).initialize();
		
		// position it
		var offset:Int = 200;
		element.x += offset * x -  offset;
		element.y += 300 + offset * y - offset ;
		
		// make clickable
		element.addEventListener(MouseEvent.CLICK, click);
		
		return element;
	}
	
	public static function click(e:Dynamic)
	{
		trace("test");
	}
}