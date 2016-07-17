package net.matthiasauer.tictactoe.model;

/**
 * The tile belongs to a player and is located at a specific position
 * @author Matthias Auer
 */
class GameTile
{
	private var x:Int;
	private var y:Int;
	private var owner:Player;

	public function new(x:Int, y:Int) 
	{
		this.x = x;
		this.y = y;
		this.owner = Player.None;
	}
	
	public function getX() : Int {
		return this.x;
	}
	
	public function getY() : Int {
		return this.y;
	}
	
	public function getOwner() : Player {
		return this.owner;
	}
	
	public function setOwner(owner:Player) : Void {
		if (owner == null) {
			throw "Null can't be assigend as owner of a GameTile";
		}
		
		if (owner == Player.None) {
			throw "Player.None can't be assigned as owner of a GameTile";
		}
		
		if (this.owner != Player.None) {
			throw "Owner can only be assigned once to a GameTile";
		}
		
		this.owner = owner;
	}
}