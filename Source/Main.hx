package;


import net.matthiasauer.di.Component;
import net.matthiasauer.di.ISystem;
import openfl.display.Sprite;
import net.matthiasauer.di.System;

class Foo implements Component {
	
	public function initializeComponent(system:ISystem) : Void {
		
	}
}

class Main extends Sprite {
	
	public function new () {
		var system:System = new System();
		
		TestMain.main();
		
		super ();
		
		system.register(Foo, []);
		
		
	}
	
	
}