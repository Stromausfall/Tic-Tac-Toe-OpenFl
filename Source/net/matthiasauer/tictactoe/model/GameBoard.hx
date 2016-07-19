package net.matthiasauer.tictactoe.model;

/**
 * ...
 * @author Matthias Auer
 */
class GameBoard
{
	private var tiles:Array<Array<GameTile>>;
	
	public function new() 
	{
		// initialize the tiles
		tiles = [for (x in 0...3) [for (y in 0...3) new GameTile(x, y)]];
	}
	
	public function getTile(x:Int, y:Int) : GameTile 
	{
		// if the coordinates are wrong
		if ((x < 0) || (x > 2) || (y < 0) || (y > 2)) {
			throw "Invalid coordinates of GameTile (" + x + "," + y + ")";
		}
		
		return tiles[x][y];
	}
}