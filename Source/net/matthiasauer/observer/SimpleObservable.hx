package net.matthiasauer.observer;

/**
 * ...
 * @author Matthias Auer
 */
class SimpleObservable
{
	private var observable:GenericObservable<Bool>;

	public function new() 
	{
		this.observable = new GenericObservable<Bool>();
	}
	
	public function add(key:String, observer:Void->Void)
	{
		var wrapper:Bool->Void =
			function(argument:Bool) 
			{
				observer();
			};
		
		this.observable.add(key, wrapper);
	}
	
	public function notify()
	{
		this.observable.notify(true);
	}
	
	public function remove(key:String)
	{
		this.observable.remove(key);
	}
	
	public function removeAll()
	{
		this.observable.removeAll();
	}
}