package net.matthiasauer.tictactoe.model;

/**
 * The tile belongs to a player and is located at a specific position
 * @author Matthias Auer
 */
class GameTile
{
	private var x:Int;
	private var y:Int;

	public function new(x:Int, y:Int) 
	{
		this.x = x;
		this.y = y;
	}
	
	public function getX() : Int {
		return this.x;
	}
	
	public function getY() : Int {
		return this.y;
	}
	
}