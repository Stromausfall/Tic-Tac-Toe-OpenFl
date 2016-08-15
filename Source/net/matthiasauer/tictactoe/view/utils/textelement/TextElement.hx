package net.matthiasauer.tictactoe.view.utils.textelement;
import net.matthiasauer.tictactoe.view.utils.element.ViewElement;
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
	
	public function initialize(initialText:String, size:Int, color:Int) : TextElement
	{
		this.textField = new TextField();
		
		this.textFormat = new TextFormat();
		this.textFormat.size = size;
		this.textFormat.align = TextFormatAlign.CENTER;
		this.textFormat.color = color;
		
		this.textField.text = initialText;
		this.textField.width = size * initialText.length;
		this.textField.height = size;
		this.textField.setTextFormat(textFormat);
		this.textField.x = -this.textField.width / 2;
		
		this.addChild(this.textField);
		
		return this;
	}
}