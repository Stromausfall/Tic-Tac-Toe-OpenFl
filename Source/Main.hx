package;

import net.matthiasauer.di.IComponent;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.controller.player.Computer;
import net.matthiasauer.tictactoe.controller.player.Human;
import net.matthiasauer.tictactoe.view.IGameView;
import net.matthiasauer.tictactoe.view.GameView;
import net.matthiasauer.tictactoe.view.svgelement.SVGFacade;
import net.matthiasauer.tictactoe.controller.Controller;
import net.matthiasauer.tictactoe.controller.IController;
import net.matthiasauer.tictactoe.model.Player;
import net.matthiasauer.tictactoe.model.GameBoard;
import net.matthiasauer.tictactoe.model.IGameBoardForView;
import net.matthiasauer.tictactoe.model.IGameBoardForModel;
import net.matthiasauer.tictactoe.model.IGameBoardForController;
import openfl.display.Sprite;
import net.matthiasauer.di.System;
import flash.events.Event;
import openfl.display.StageScaleMode;
import openfl.Lib;

class Main extends Sprite {
	var originalWidth:Float;
	var originalHeight:Float;
	
	public function resize (newWidth:Int, newHeight:Int):Void {
		var maxWidthScale = newWidth / originalWidth;
		var maxHeightScale = newHeight / originalHeight;
		var newScale = Math.min(maxWidthScale, maxHeightScale);
		
		this.stage.scaleX = newScale;
		this.stage.scaleY = newScale;
		
		this.x = newWidth / (newScale * 2);
	}
	
	public function new () {
		super ();
		
		
		TestMain.main();
		
		var system:ISystem = new System();
		system.register(GameView, [IGameView]);
		system.register(GameBoard, [IGameBoardForView, IGameBoardForController, IGameBoardForModel]);
		system.register(Controller, [IController]);
		
		var gameView:IGameView = system.get(IGameView);
		var controller:IController = system.get(IController);
		var gameBoard:IGameBoardForController = system.get(IGameBoardForController);
		
		controller.setPlayers(new Human(Player.Player1, gameBoard), new Computer(Player.Player2, gameBoard));
		//controller.setPlayers(new Computer(Player.Player1, gameBoard), new Computer(Player.Player2, gameBoard));
		
		this.addChild(gameView.getDisplayObject());
		gameView.reset();
		
		
		
		this.originalHeight = stage.stageHeight;
		this.originalWidth = stage.stageWidth;
		
		stage.addEventListener (Event.RESIZE, stage_onResize);
		
		
		controller.startGame();
	}
	
	
	private function stage_onResize (event:Event):Void {
		var newWidth:Int = stage.stageWidth;
		var newHeight:Int = stage.stageHeight;

		this.resize(newWidth, newHeight);
	}
}