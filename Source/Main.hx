package;

import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.di.System;
import net.matthiasauer.tictactoe.controller.player.Computer;
import net.matthiasauer.tictactoe.controller.player.Human;
import net.matthiasauer.tictactoe.view.IGameView;
import net.matthiasauer.tictactoe.view.IViewManager;
import net.matthiasauer.tictactoe.view.GameView;
import net.matthiasauer.tictactoe.view.Resizing;
import net.matthiasauer.tictactoe.view.ViewManager;
import net.matthiasauer.tictactoe.view.svgelement.SVGFacade;
import net.matthiasauer.tictactoe.controller.Controller;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.model.GameBoard;
import net.matthiasauer.tictactoe.model.IGameBoardForView;
import net.matthiasauer.tictactoe.model.IGameBoardForModel;
import net.matthiasauer.tictactoe.model.IGameBoardForController;
import openfl.Lib;
import openfl.display.Sprite;

class Main extends Sprite {	
	public function new () {
		super ();
		
		
		TestMain.main();
		
		var system:ISystem = new System();
		system.register(GameView, [IGameView]);
		system.register(GameBoard, [IGameBoardForView, IGameBoardForController, IGameBoardForModel]);
		system.register(Controller, [IController]);
		system.register(ViewManager, [IViewManager]);
		
		var gameView:IGameView = system.get(IGameView);
		var controller:IController = system.get(IController);
		var gameBoard:IGameBoardForController = system.get(IGameBoardForController);
		
		controller.setPlayers(new Human(Player.Player1, gameBoard), new Computer(Player.Player2, gameBoard));
		//controller.setPlayers(new Computer(Player.Player1, gameBoard), new Computer(Player.Player2, gameBoard));
		
		this.addChild(gameView.getDisplayObject());
		gameView.reset();
		
		
		Lib.trace(" --- " + Type.getClassName(Type.getClass(this.stage)));
		
		new Resizing(this).initialize();
		
		controller.startGame();
	}
}