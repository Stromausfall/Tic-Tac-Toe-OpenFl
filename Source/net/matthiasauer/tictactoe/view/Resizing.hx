package net.matthiasauer.tictactoe.view;
import openfl.events.Event;
import openfl.display.Stage;
import openfl.display.StageScaleMode;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
class Resizing
{
	private var sprite:Sprite;
	private var originalWidth:Float;
	private var originalHeight:Float;
	
	private function resize (newWidth:Int, newHeight:Int):Void {
		var maxWidthScale = newWidth / originalWidth;
		var maxHeightScale = newHeight / originalHeight;
		var newScale = Math.min(maxWidthScale, maxHeightScale);
		
		this.sprite.stage.scaleX = newScale;
		this.sprite.stage.scaleY = newScale;
		
		this.sprite.x = newWidth / (newScale * 2);
	}

	public function new(sprite:Sprite) 
	{
		this.sprite = sprite;
	}
	
	public function initialize() : Resizing
	{
		this.originalHeight = this.sprite.stage.stageHeight;
		this.originalWidth = this.sprite.stage.stageWidth;
		
		this.sprite.stage.addEventListener (Event.RESIZE, this.stage_onResize);
		
		return this;
	}
	
	
	private function stage_onResize (event:Event):Void {
		var newWidth:Int = this.sprite.stage.stageWidth;
		var newHeight:Int = this.sprite.stage.stageHeight;

		this.resize(newWidth, newHeight);
	}
}