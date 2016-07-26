package;

import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.view.SVGFacade;
import net.matthiasauer.tictactoe.model.Player;
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
		
		this.addChild(SVGFacade.createGameBoard());
		this.addChild(SVGFacade.createGameTile(Player.Computer, 0, 0));
		this.addChild(SVGFacade.createGameTile(Player.Human, 0, 1));
		this.addChild(SVGFacade.createGameTile(Player.Computer, 0, 2));
		this.addChild(SVGFacade.createGameTile(Player.Human, 1, 0));
		this.addChild(SVGFacade.createGameTile(Player.Computer, 1, 1));
		this.addChild(SVGFacade.createGameTile(Player.Human, 1, 2));
		this.addChild(SVGFacade.createGameTile(Player.Computer, 2, 0));
		this.addChild(SVGFacade.createGameTile(Player.Human, 2, 1));
		this.addChild(SVGFacade.createGameTile(Player.Computer, 2, 2));
		
		
		this.originalHeight = stage.stageHeight;
		this.originalWidth = stage.stageWidth;
		
		stage.addEventListener (Event.RESIZE, stage_onResize);
	}
	
	
	private function stage_onResize (event:Event):Void {
		var newWidth:Int = stage.stageWidth;
		var newHeight:Int = stage.stageHeight;

		this.resize(newWidth, newHeight);
	}
}