package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;

/**
 * ...
 * @author Matthias Auer
 */
class GameBoard implements IGameBoard implements Component
{
	private var horizontalTilesCount = 3;
	private var verticalTilesCount = 3;
	private var tiles:Array<Array<GameTile>>;
	
	public function new() 
	{
		// initialize the tiles
		tiles = [for (x in 0...this.horizontalTilesCount) [for (y in 0...this.verticalTilesCount) new GameTile(x, y)]];
	}
	
	public function getTile(x:Int, y:Int) : GameTile 
	{
		// if the coordinates are wrong
		if ((x < 0) || (x >= this.horizontalTilesCount) || (y < 0) || (y >= this.verticalTilesCount)) {
			throw "Invalid coordinates of GameTile (" + x + "," + y + ")";
		}
		
		return tiles[x][y];
	}
	
	public function getHorizontalTilesCount() : Int
	{
		return this.horizontalTilesCount;
	}
	
	public function getVerticalTilesCount() : Int
	{
		return this.verticalTilesCount;
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		
	}
}