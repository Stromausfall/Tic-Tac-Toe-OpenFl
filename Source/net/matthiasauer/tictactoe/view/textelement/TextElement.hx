package net.matthiasauer.tictactoe.view.textelement;
import net.matthiasauer.tictactoe.view.element.ViewElement;
import openfl.display.DisplayObject;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;

/**
 * ...
 * @author Matthias Auer
 */
class TextElement extends ViewElement
{
	private var textField:TextField;
	private var textFormat:TextFormat;

	public function new() 
	{
		super();
	}
	
	override private function getDisplayObject() : DisplayObject
	{
		return this.textField;
	}
	
	public function initialize(initialText:String, size:Int) : TextElement
	{
		this.textField = new TextField();
		
		this.textFormat = new TextFormat();
		this.textFormat.size = 48;
		this.textFormat.align = TextFormatAlign.CENTER;
		this.textFormat.color = 0xFF0000;
		
		this.textField.text = initialText;
		this.textField.width = 400;
		this.textField.setTextFormat(textFormat);
		this.textField.x = -this.textField.width/2;
		
		this.addChild(this.textField);
		
		return this;
	}
}