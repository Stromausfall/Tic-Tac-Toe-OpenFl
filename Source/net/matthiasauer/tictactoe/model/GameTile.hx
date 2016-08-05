package net.matthiasauer.tictactoe.model;
import net.matthiasauer.observer.Observable;

/**
 * The tile belongs to a player and is located at a specific position
 * @author Matthias Auer
 */
class GameTile implements IGameTile
{
	private var observable:Observable<Bool>;
	private var owner:Player;

	public function new() 
	{
		this.owner = Player.None;
		this.observable = new Observable<Bool>();
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
		
		// notify observers
		this.observable.notify(true);
	}
	
	public function addObserver(observer:Void->Void) : Void
	{
		var wrapperLambda = function(f:Bool) { observer(); };
		
		this.observable.add("mainObserver", wrapperLambda);
	}
}