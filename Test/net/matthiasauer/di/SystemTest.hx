package net.matthiasauer.di;
import haxe.unit.TestCase;

interface TestClass1View1 extends ComponentView
{
}

interface TestClass1View2 extends ComponentView
{
}

class TestClass1 implements Component implements TestClass1View1 implements TestClass1View2
{
	public function new()
	{	
	}
	
	public function initialize() : Void
	{	
	}
}

interface TestClass2View1 extends ComponentView
{
}

interface TestClass2View2 extends ComponentView
{
}

class TestClass2 implements Component implements TestClass2View1 implements TestClass2View2
{
	public function new()
	{	
	}
	
	public function initialize() : Void
	{	
	}
}

/**
 * ...
 * @author Matthias Auer
 */
class SystemTest extends TestCase
{
	/**
	 * Called before each test !
	 */
	override public function setup() {
		System.clear();
	}
	
	public function testThatAnExceptionIsThrownIfWeWantAnUnregisteredInstance():Void
	{
		var exceptionThrown:Bool = false;
		
		try {
			System.get(TestClass1);
		} catch (msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	public function testThatSystemClearWorksForTheClassItself():Void 
	{
		System.register(TestClass1, []);
		
		// no exception should happen herre because the class has been registered
		System.get(TestClass1);
		
		System.clear();
		
		// now we expect an exception
		var exceptionThrown:Bool = false;
		
		try {
			System.get(TestClass1);
		} catch (msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	public function testThatAnInstanceIsReturnedForTheRegisteredClass():Void
	{
		System.register(TestClass1, []);
		
		ensureTypeAndInstance(TestClass1);
	}
	
	private function ensureTypeAndInstance(clazz : Class<Dynamic>):Void
	{	
		var instance:Dynamic = System.get(clazz);

		// make sure something was returned
		assertTrue(instance != null);
		
		// make sure the correct type was returned
		assertTrue(Std.instance(instance, clazz) != null);
	}
	
	public function testThatTheRegisteredViewsReturnTheRegisteredClassToo():Void
	{
		System.register(TestClass1, [TestClass1View1, TestClass1View2]);
		
		ensureTypeAndInstance(TestClass1);
		ensureTypeAndInstance(TestClass1View1);
		ensureTypeAndInstance(TestClass1View2);
	}
	
	public function testThatTheSameInstanceIsReturned():Void 
	{
		System.register(TestClass1, [TestClass1View1, TestClass1View2]);
		
		// no exception should happen herre because the class has been registered
		var instance1 = System.get(TestClass1);
		var instance2 = System.get(TestClass1);
		
		assertEquals(instance1, instance2);
	}
	
	public function testThatDifferentClassesReturnADifferentInstance():Void 
	{
		System.register(TestClass1, [TestClass1View1, TestClass1View2]);
		System.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// no exception should happen herre because the class has been registered
		var instance1 = System.get(TestClass1);
		var instance2 = System.get(TestClass2);
		
		assertTrue(instance1 != null);
		assertTrue(instance2 != null);
		assertTrue(Type.typeof(instance1) != Type.typeof(instance2));
	}
	
	public function testThatSystemClearAlsoRemovesInstances():Void 
	{
		System.register(TestClass1, []);
		var instancePreClear = System.get(TestClass1);
		
		System.clear();
		
		System.register(TestClass1, []);
		var instancePostClear = System.get(TestClass1);
		
		assertTrue(instancePreClear != instancePostClear);
	}
}