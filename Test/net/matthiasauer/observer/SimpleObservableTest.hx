package net.matthiasauer.observer;
import haxe.unit.TestCase;

/**
 * ...
 * @author Matthias Auer
 */
class SimpleObservableTest extends TestCase
{
	public function new() 
	{
		super();
	}

	public function testAddObserverAndNotifyWorks()
	{
		var id:String = "id#1";
		var observable:SimpleObservable = new SimpleObservable();
		var notified:Bool = false;
		
		// add the observer
		observable.add(id, function() { notified = true; });
		
		// notify observers
		assertFalse(notified);
		observable.notify();
		assertTrue(notified);
	}
	
	public function testAddMultipleObserversAndNotify() 
	{
		var test1:Bool = false;
		var test2:Bool = false;
		var test3:Bool = false;
		var observable:SimpleObservable = new SimpleObservable();
		
		// add the observer
		observable.add("id#1", function() { test1 = true; });
		observable.add("id#2", function() { test2 = true; });
		observable.add("id#3", function() { test3 = true; });
		
		// notify observers
		observable.notify();
		
		assertTrue(test1);
		assertTrue(test2);
		assertTrue(test3);
	}
	
	public function testDeleteObserverById() 
	{
		var test1:Bool = false;
		var test2:Bool = false;
		var test3:Bool = false;
		var test4:Bool = false;
		var observable:SimpleObservable = new SimpleObservable();
		
		// add the observer
		observable.add("id#1", function() { test1 = true; });
		observable.add("id#2", function() { test2 = true; });
		observable.add("id#3", function() { test3 = true; });
		observable.add("id#4", function() { test4 = true; });
		
		observable.remove("id#2");
		observable.remove("id#3");
		
		// notify observers
		observable.notify();
		
		assertTrue(test1);
		assertFalse(test2);
		assertFalse(test3);
		assertTrue(test4);
	}
	
	public function testRemoveAllObserversAndNotify() 
	{
		var test1:Bool = false;
		var test2:Bool = false;
		var test3:Bool = false;
		var observable:SimpleObservable = new SimpleObservable();
		
		// add the observer
		observable.add("id#1", function() { test1 = true; });
		observable.add("id#2", function() { test2 = true; });
		observable.add("id#3", function() { test3 = true; });
		
		observable.removeAll();
		
		// notify observers
		observable.notify();
		
		assertFalse(test1);
		assertFalse(test2);
		assertFalse(test3);
	}
	
}