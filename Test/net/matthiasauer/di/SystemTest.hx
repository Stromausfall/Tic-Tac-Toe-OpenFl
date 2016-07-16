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
	
	public function initializeComponent() : Void
	{
	}
}

interface TestClass2View1 extends ComponentView
{
	function getDependencyTestClass1() : TestClass1View1;
	function getInitializedCount() : Int;
}

interface TestClass2View2 extends ComponentView
{
}

class TestClass2 implements Component implements TestClass2View1 implements TestClass2View2
{
	private var dependency:TestClass1View1;
	private var initializedCount:Int = 0;
	
	public function getDependencyTestClass1() : TestClass1View1
	{
		return this.dependency;
	}
	
	public function new()
	{	
	}
	
	public function getInitializedCount() : Int
	{
		return this.initializedCount;
	}
	
	public function initializeComponent() : Void
	{
		dependency = System.get(TestClass1View1);
		initializedCount += 1;
	}
}

interface TestClass3View1 extends ComponentView
{
	function getDependencyTestClass4() : TestClass4View1;
}

class TestClass3 implements Component implements TestClass3View1
{
	private var dependency:TestClass4View1;
	
	public function getDependencyTestClass4() : TestClass4View1
	{
		return this.dependency;
	}
	
	public function new()
	{	
	}
	
	public function initializeComponent() : Void
	{
		dependency = System.get(TestClass4View1);
	}
}

interface TestClass4View1 extends ComponentView
{
	function getDependencyTestClass3() : TestClass3View1;
	function getInitializedCount() : Int;
}

class TestClass4 implements Component implements TestClass4View1
{
	private var dependency:TestClass3View1;
	private var dependency2:TestClass4View1;
	private var initializedCount:Int = 0;
	
	public function getDependencyTestClass3() : TestClass3View1
	{
		return this.dependency;
	}
	
	public function getInitializedCount() : Int
	{
		return this.initializedCount;
	}
	
	public function new()
	{	
	}
	
	public function initializeComponent() : Void
	{
		this.initializedCount += 1;
		dependency = System.get(TestClass3View1);
		dependency2 = System.get(TestClass4View1);
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
	
	public function testThatSimpleDependencyIsResolved() : Void
	{
		System.register(TestClass1, [TestClass1View1, TestClass1View2]);
		System.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// the TestClass2 instance should now have a reference to the TestClass1 !
		var testClass2:TestClass2View1 = System.get(TestClass2View1);
		
		// it should be the same as the one we get from the System
		var testClass1InTestClass2:TestClass1View1 = testClass2.getDependencyTestClass1();
		
		assertEquals(testClass1InTestClass2, System.get(TestClass1View1));
		
		// make sure it isn't null...
		assertTrue(testClass1InTestClass2 != null);
	}
	
	public function testThatInitializeIsOnlyCalledOnce() : Void
	{
		System.register(TestClass1, [TestClass1View1, TestClass1View2]);
		System.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// the TestClass2 instance should now have a reference to the TestClass1 !
		var testClass2:TestClass2View1 = System.get(TestClass2View1);
		testClass2 = System.get(TestClass2View1);
		
		assertEquals(testClass2.getInitializedCount(), 1);
	}
	
	public function testThatCircularDependencyIsResolved() : Void 
	{
		System.register(TestClass3, [TestClass3View1]);
		System.register(TestClass4, [TestClass4View1]);
		
		// the TestClass3 instance should now have a reference to the TestClass4 !
		var testClass4:TestClass4View1 = System.get(TestClass4View1);
		var testClass3:TestClass3View1 = System.get(TestClass3View1);
		
		assertEquals(testClass4.getDependencyTestClass3(), System.get(TestClass3View1));
		assertEquals(testClass3.getDependencyTestClass4(), System.get(TestClass4View1));		
		assertEquals(testClass4.getInitializedCount(), 1);
	}
}