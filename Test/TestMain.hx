package;
import net.matthiasauer.di.SystemForMocks;
import net.matthiasauer.di.SystemForMocksTest;
import net.matthiasauer.di.SystemTest;
import net.matthiasauer.observer.ObserverTest;
import net.matthiasauer.tictactoe.model.GameBoardTest;
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
		r.add(new ObserverTest());
		
		// test Model
		r.add(new GameTileTest());
		r.add(new GameBoardTest());
		
		// test Controller
		
		r.run();
	}
	
}