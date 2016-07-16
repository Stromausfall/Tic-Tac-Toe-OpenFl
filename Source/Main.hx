package;


import net.matthiasauer.di.Component;
import openfl.display.Sprite;
import net.matthiasauer.di.System;

class Foo implements Component {
	
	public function initializeComponent() : Void {
		
	}
}

class Main extends Sprite {
	
	public function new () {
		
		TestMain.main();
		
		super ();
		
		System.register(Foo, []);
		
		
	}
	
	
}