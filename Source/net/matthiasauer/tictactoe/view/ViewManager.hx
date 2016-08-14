package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.model.IGameManagerForView;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class ViewManager extends Sprite implements IComponent implements IViewManager
{
	private var gameView:IGameView;
	private var gameManager:IGameManagerForView;
	
	public function new() 
	{
		super();
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameView = system.get(IGameView);
		this.gameManager = system.get(IGameManagerForView);
	}
	
	public function initialize(parent:Sprite) : Void
	{
		// add the ViewManager to the root sprite
		parent.addChild(this);
		
		// initialize and use the resizing functionality
		new Resizing(this).initialize();
		
		// register the listener
		this.gameManager.addObserver(this.observeGameStatus);
		
		// get the initial state and display it
		this.observeGameStatus();		
	}
	
	private function observeGameStatus() : Void
	{
		this.resetAllView();
		
		switch (this.gameManager.getStatus()) {
			case GAME:
				this.displayGameView();
			case MENU:
				this.displayMenuView();
		}
	}
	
	private function resetAllView()
	{
		this.removeChild(this.gameView.getDisplayObject());
	}
	
	private function displayMenuView()
	{
	}
	
	private function displayGameView()
	{
		// display the game view
		this.addChild(gameView.getDisplayObject());
		gameView.reset();
	}
}