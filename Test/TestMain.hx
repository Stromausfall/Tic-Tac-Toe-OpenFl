package;
import net.matthiasauer.di.SystemTest;

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
		
		r.run();
	}
	
}