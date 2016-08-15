package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.model.IGameManagerForView;
import net.matthiasauer.tictactoe.view.game.IGameView;
import net.matthiasauer.tictactoe.view.menu.IMenuView;
import net.matthiasauer.tictactoe.view.utils.view.IView;
import net.matthiasauer.tictactoe.view.utils.view.Resizing;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class ViewManager extends Sprite implements IComponent implements IViewManager
{
	private var gameView:IView;
	private var menuView:IView;
	private var gameManager:IGameManagerForView;
	
	public function new() 
	{
		super();
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameView = system.get(IGameView);
		this.menuView = system.get(IMenuView);
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
				this.displayView(this.gameView);
			case MENU:
				this.displayView(this.menuView);
		}
	}
	
	private function resetAllView()
	{
		this.removeChild(this.gameView.getDisplayObject());
		this.removeChild(this.menuView.getDisplayObject());
	}
	
	private function displayView(view:IView)
	{
		// display the view
		this.addChild(view.getDisplayObject());
		
		// reset its state
		view.reset();
	}
}