package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.IComponentView;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.model.IGameBoardForView;
import net.matthiasauer.tictactoe.model.IGameTile;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.view.element.data.Fading;
import net.matthiasauer.tictactoe.view.svgelement.SVGElement;
import net.matthiasauer.tictactoe.view.svgelement.SVGFacade;
import net.matthiasauer.tictactoe.view.textelement.TextElement;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class GameView extends Sprite implements IComponent implements IComponentView
{
	private var gameBoard:IGameBoardForView;
	private var controller:IController;
	private var tiles:Array<Array<SVGElement>>;
	
	public function new() 
	{
		super();
	}

	public function initializeComponent(system:ISystem) : Void
	{
		this.gameBoard = system.get(IGameBoardForView);
		this.controller = system.get(IController);
	}
	
	public function reset()
	{
		var horizontalTiles:Int = this.gameBoard.getHorizontalTilesCount();
		var verticalTiles:Int = this.gameBoard.getVerticalTilesCount();
		
		// initialize the tiles
		this.tiles = [for (x in 0...horizontalTiles) [for (y in 0...verticalTiles) null]];
		
		this.addChild(SVGFacade.createGameBoard());
		// any change to the owner of the game tiles causes the view to display a different game tile
		for (x in 0...horizontalTiles) {
			for (y in 0...verticalTiles) {
				this.changeGameTile(x, y, Player.None);
				
				// install a listener for each tile
				this.installListenerOnModelGameTile(x, y);
			}
		}
		
		this.addChild(new TextElement().initialize(" test ", 48));
	}
	
	private function changeGameTile(x:Int, y:Int, newOwner:Player)
	{
		// remove the old tile
		this.removeOldTile(x, y);
		
		// create the new tile
		var newTile:SVGElement = SVGFacade.createGameTile(newOwner, x, y, controller);
		
		// and add it
		this.addChild(newTile);
		this.tiles[x][y] = newTile;
	}
	
	private function removeOldTile(x:Int, y:Int)
	{
		var oldTile:SVGElement = this.tiles[x][y];
		
		if (oldTile != null) 
		{
			this.removeChild(oldTile);
		}
	}
	
	private function installListenerOnModelGameTile(x, y) 
	{
		var tile:IGameTile = this.gameBoard.getTile(x, y);
		var observeFunction:Void->Void =
			function() 
			{
				// get the new owner
				var newOwner:Player = this.gameBoard.getTile(x, y).getOwner();
				
				// change the view accordingly
				this.changeGameTile(x, y, newOwner);
			};
		
		// install the listener on the tile model
		tile.addObserver(observeFunction);
	}
	
	public function getDisplayObject() : DisplayObject
	{
		return this;
	}
}