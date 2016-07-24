package;

import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.view.SVGExample;
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
		
		this.addChild(new SVGExample());
		
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