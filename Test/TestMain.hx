package;
import net.matthiasauer.di.SystemTest;
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
		
		// test Model
		r.add(new GameTileTest());
		r.add(new GameBoardTest());
		
		r.run();
	}
	
}