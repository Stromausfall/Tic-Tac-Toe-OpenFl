package;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.di.SystemForMocksTest;
import net.matthiasauer.di.SystemTest;
import net.matthiasauer.observer.GenericObservableTest;
import net.matthiasauer.observer.SimpleObservableTest;
import net.matthiasauer.tictactoe.controller.ControllerTest;
import net.matthiasauer.tictactoe.controller.player.ComputerTest;
import net.matthiasauer.tictactoe.controller.player.HumanTest;
import net.matthiasauer.tictactoe.model.GameBoardTest;
import net.matthiasauer.tictactoe.model.GameManagerTest;
import net.matthiasauer.tictactoe.model.GameTileTest;

/**
 * ...
 * @author Matthias Auer
 */
class TestMain
{
	public static function main()
	{
		var r = new haxe.unit.TestRunner();
		
		// test Dependency Injection
		r.add(new SystemTest());
		r.add(new SystemForMocksTest());
		
		// test observer
		r.add(new GenericObservableTest());
		r.add(new SimpleObservableTest());
		
		// test Model
		r.add(new GameTileTest());
		r.add(new GameBoardTest());
		r.add(new GameManagerTest());
		
		// test Controller
		r.add(new ControllerTest());
		r.add(new HumanTest());
		r.add(new ComputerTest());
		
		r.run();
	}
	
}