package net.matthiasauer.tictactoe.view.menu;
import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.view.utils.element.ViewElement;
import net.matthiasauer.tictactoe.view.utils.element.data.Clickable;
import net.matthiasauer.tictactoe.view.utils.textelement.TextElement;
import openfl.display.DisplayObject;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class MenuView extends Sprite implements IMenuView implements IComponent
{
	private var controller:IController = null;
	
	public function new() 
	{
		super();
	}
	
	public function getDisplayObject() : DisplayObject
	{
		return this;
	}
	
	public function reset() : Void 
	{
		
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.controller = system.get(IController);
		
		var newGameButton:ViewElement = new TextElement().initialize("New Game", 100, 0x000000);
		
		newGameButton.y = 200;
		
		var methodToCall:Void->Void = this.controller.notifyNewGameClick;
		newGameButton.addData(new Clickable(methodToCall));
		
		this.addChild(newGameButton);
	}
}