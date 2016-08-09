package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class ViewManager extends Sprite implements IComponent implements IViewManager
{
	private var gameView:IGameView;
	
	public function new() 
	{
		super();
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.gameView = system.get(IGameView);
	}
	
	public function initialize(parent:Sprite) : Void
	{
		// add the ViewManager to the root sprite
		parent.addChild(this);
		
		// initialize and use the resizing functionality
		new Resizing(this).initialize();
		
		// display the game view
		this.addChild(gameView.getDisplayObject());
		gameView.reset();
	}
}