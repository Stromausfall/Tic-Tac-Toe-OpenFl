package;


import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;
import net.matthiasauer.tictactoe.view.SVGExample;
import openfl.display.Sprite;
import net.matthiasauer.di.System;

class Main extends Sprite {
	
	public function new () {
		super ();
		
		this.addChild(new SVGExample());
	}
	
	
}