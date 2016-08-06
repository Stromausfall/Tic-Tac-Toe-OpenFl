package net.matthiasauer.di;
import haxe.unit.TestCase;

interface TestClass1View1 extends IComponentView
{
}

interface TestClass1View2 extends IComponentView
{
}

class TestClass1 implements IComponent implements TestClass1View1 implements TestClass1View2
{
	public function new()
	{	
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
	}
}

interface TestClass2View1 extends IComponentView
{
	function getDependencyTestClass1() : TestClass1View1;
	function getInitializedCount() : Int;
}

interface TestClass2View2 extends IComponentView
{
}

class TestClass2 implements IComponent implements TestClass2View1 implements TestClass2View2
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
	
	public function initializeComponent(system:ISystem) : Void
	{
		dependency = system.get(TestClass1View1);
		initializedCount += 1;
	}
}

interface TestClass3View1 extends IComponentView
{
	function getDependencyTestClass4() : TestClass4View1;
}

class TestClass3 implements IComponent implements TestClass3View1
{
	private var dependency:TestClass4View1;
	
	public function getDependencyTestClass4() : TestClass4View1
	{
		return this.dependency;
	}
	
	public function new()
	{	
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
		dependency = system.get(TestClass4View1);
	}
}

interface TestClass4View1 extends IComponentView
{
	function getDependencyTestClass3() : TestClass3View1;
	function getInitializedCount() : Int;
}

class TestClass5 implements IComponent implements TestClass5View1
{
	public function new()
	{
		
	}
	
	public function initializeComponent(system:ISystem) : Void
	{
	}
}

class TestClass6 extends TestClass5
{
	public function new()
	{
		super();
	}
}

interface TestClass5View1 extends IComponentView
{
}

class TestClass4 implements IComponent implements TestClass4View1
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
	
	public function initializeComponent(system:ISystem) : Void
	{
		this.initializedCount += 1;
		dependency = system.get(TestClass3View1);
		dependency2 = system.get(TestClass4View1);
	}
}


/**
 * ...
 * @author Matthias Auer
 */
class SystemTest extends TestCase
{	
	public function testThatAnExceptionIsThrownIfWeWantAnUnregisteredInstance():Void
	{
		var system:ISystem = new System();
		var exceptionThrown:Bool = false;
		
		try {
			system.get(TestClass1);
		} catch (msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	private function ensureTypeAndInstance(system : ISystem, clazz : Class<Dynamic>):Void
	{
		var instance:Dynamic = system.get(clazz);

		// make sure something was returned
		assertTrue(instance != null);
		
		// make sure the correct type was returned
		assertTrue(Std.instance(instance, clazz) != null);
	}
	
	public function testThatTheRegisteredViewsDoesntReturnTheRegisteredClassItself():Void
	{
		var system:ISystem = new System();
		system.register(TestClass1, [TestClass1View1, TestClass1View2]);
		var exceptionThrown:Bool = false;
		
		try {
			system.get(TestClass1);
		} catch (msg : String) {
			exceptionThrown = true;
		}
		
		assertTrue(exceptionThrown);
	}
	
	public function testThatTheSameInstanceIsReturned():Void 
	{
		var system:ISystem = new System();
		system.register(TestClass1, [TestClass1View1, TestClass1View2]);
		
		// no exception should happen herre because the class has been registered
		var instance1 = system.get(TestClass1View1);
		var instance2 = system.get(TestClass1View1);
		
		assertEquals(instance1, instance2);
	}
	
	public function testThatDifferentClassesReturnADifferentInstance():Void 
	{
		var system:ISystem = new System();
		system.register(TestClass1, [TestClass1View1, TestClass1View2]);
		system.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// no exception should happen herre because the class has been registered
		var instance1 = system.get(TestClass1View1);
		var instance2 = system.get(TestClass2View1);
		
		assertTrue(instance1 != null);
		assertTrue(instance2 != null);
		assertTrue(Type.typeof(instance1) != Type.typeof(instance2));
	}
	
	public function testThatSimpleDependencyIsResolved() : Void
	{
		var system:ISystem = new System();
		system.register(TestClass1, [TestClass1View1, TestClass1View2]);
		system.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// the TestClass2 instance should now have a reference to the TestClass1 !
		var testClass2:TestClass2View1 = system.get(TestClass2View1);
		
		// it should be the same as the one we get from the System
		var testClass1InTestClass2:TestClass1View1 = testClass2.getDependencyTestClass1();
		
		assertEquals(testClass1InTestClass2, system.get(TestClass1View1));
		
		// make sure it isn't null...
		assertTrue(testClass1InTestClass2 != null);
	}
	
	public function testThatInitializeIsOnlyCalledOnce() : Void
	{
		var system:ISystem = new System();
		system.register(TestClass1, [TestClass1View1, TestClass1View2]);
		system.register(TestClass2, [TestClass2View1, TestClass2View2]);
		
		// the TestClass2 instance should now have a reference to the TestClass1 !
		var testClass2:TestClass2View1 = system.get(TestClass2View1);
		testClass2 = system.get(TestClass2View1);
		
		assertEquals(testClass2.getInitializedCount(), 1);
	}
	
	public function testThatCircularDependencyIsResolved() : Void 
	{
		var system:ISystem = new System();
		system.register(TestClass3, [TestClass3View1]);
		system.register(TestClass4, [TestClass4View1]);
		
		// the TestClass3 instance should now have a reference to the TestClass4 !
		var testClass4:TestClass4View1 = system.get(TestClass4View1);
		var testClass3:TestClass3View1 = system.get(TestClass3View1);
		
		assertEquals(testClass4.getDependencyTestClass3(), system.get(TestClass3View1));
		assertEquals(testClass3.getDependencyTestClass4(), system.get(TestClass4View1));		
		assertEquals(testClass4.getInitializedCount(), 1);
	}
}