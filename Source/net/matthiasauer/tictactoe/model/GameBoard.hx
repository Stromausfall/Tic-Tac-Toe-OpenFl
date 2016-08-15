package net.matthiasauer.tictactoe.model;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;

/**
 * ...
 * @author Matthias Auer
 */
class GameBoard implements IGameBoardForModel implements IComponent
{
	private var horizontalTilesCount = 3;
	private var verticalTilesCount = 3;
	private var gameManager:IGameManagerForModel;
	private var tiles:Array<Array<GameTile>>;
	
	public function new() 
	{
		// initialize the tiles
		tiles = [for (x in 0...this.horizontalTilesCount) [for (y in 0...this.verticalTilesCount) new GameTile()]];
	}
	
	public function getTile(x:Int, y:Int) : IGameTile 
	{
		// if the coordinates are wrong
		if ((x < 0) || (x >= this.horizontalTilesCount) || (y < 0) || (y >= this.verticalTilesCount)) {
			throw "Invalid coordinates of GameTile (" + x + "," + y + ")";
		}
		
		return this.tiles[x][y];
	}
	
	public function getHorizontalTilesCount() : Int
	{
		return this.horizontalTilesCount;
	}
	
	public function getVerticalTilesCount() : Int
	{
		return this.verticalTilesCount;
	}
	
	public function changeOwner(x:Int, y:Int, newOwner:Player) : Void
	{
		this.tiles[x][y].setOwner(newOwner);
		
		if (this.checkVictoryFor(newOwner))
		{
			this.gameManager.gameIsOver();
		}
		
	}
	
	private function checkVictoryFor(player:Player) : Bool
	{
		return this.checkHorizontalFor(player) || this.checkVerticalFor(player) || this.checkDiagonal1(player) || this.checkDiagonal2(player);
	}
	
	private function isOwned(player:Player, x:Int, y:Int) : Bool
	{
		var ownerOfTile:Player = this.getTile(x, y).getOwner();
		
		return ownerOfTile == player;
	}
	
	private function checkDiagonal1(player:Player) : Bool
	{
		var allOwned:Bool = true;
		
		allOwned = allOwned && this.isOwned(player, 0, 0);
		allOwned = allOwned && this.isOwned(player, 1, 1);
		allOwned = allOwned && this.isOwned(player, 2, 2);
		
		return allOwned;
	}
	
	private function checkDiagonal2(player:Player) : Bool
	{
		var allOwned:Bool = true;
		
		allOwned = allOwned && this.isOwned(player, 2, 0);
		allOwned = allOwned && this.isOwned(player, 1, 1);
		allOwned = allOwned && this.isOwned(player, 0, 2);
		
		return allOwned;
	}
	
	private function checkHorizontalFor(player:Player) : Bool
	{
		// horizontal
		for (y in 0...this.getVerticalTilesCount()) 
		{
			var allOwned:Bool = true;
			
			for (x in 0...this.getHorizontalTilesCount()) 
			{
				allOwned = allOwned && this.isOwned(player, x, y);
			}

			if (allOwned)
			{
				return true;
			}
		}
		
		return false;
	}
	
	private function checkVerticalFor(player:Player) : Bool
	{
		// horizontal
		for (x in 0...this.getHorizontalTilesCount()) 
		{
			var allOwned:Bool = true;
			
			for (y in 0...this.getVerticalTilesCount()) 
			{
				allOwned = allOwned && this.isOwned(player, x, y);
			}

			if (allOwned)
			{
				return true;
			}
		}
		
		return false;
	}
	
	public function resetBoard() : Void
	{
		for (x in 0...this.horizontalTilesCount)
		{
			for (y in 0...this.verticalTilesCount)
			{
				this.tiles[x][y].resetOwner();
			}
		}
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameManager = system.get(IGameManagerForModel);
	}
}