package net.matthiasauer.tictactoe.view.game;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.IComponentView;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.model.IGameBoardForView;
import net.matthiasauer.tictactoe.model.IGameManagerForView;
import net.matthiasauer.tictactoe.model.IGameTile;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.view.utils.element.data.Fading;
import net.matthiasauer.tictactoe.view.utils.svgelement.SVGElement;
import net.matthiasauer.tictactoe.view.utils.svgelement.SVGFacade;
import net.matthiasauer.tictactoe.view.utils.textelement.TextElement;
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
	private var gameManager:IGameManagerForView;
	private var tiles:Array<Array<SVGElement>>;
	private var gameEndStatus:DisplayObject;
	
	public function new() 
	{
		super();
	}

	public function initializeComponent(system:ISystem) : Void
	{
		this.gameBoard = system.get(IGameBoardForView);
		this.controller = system.get(IController);
		this.gameManager = system.get(IGameManagerForView);
		
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
		
		// install the listener on the winner
		this.gameManager.addGameOverObserver(this.displayGameOver);
	}
	
	private function displayGameOver()
	{
		var player:Player = this.gameManager.getWinner();
		var message:String = "";
		
		if (player == Player.None)
		{
			message = "Draw";
		} else {
			message = player + " won";
		}
		
		this.gameEndStatus = new TextElement().initialize(message, 100, 0x0F0FFF);
		this.gameEndStatus.y = 200;
		this.addChild(this.gameEndStatus);
	}
	
	public function reset()
	{
		if (this.gameEndStatus != null)
		{
			this.removeChild(this.gameEndStatus);
		}
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