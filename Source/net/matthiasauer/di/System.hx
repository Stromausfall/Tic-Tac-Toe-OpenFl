package net.matthiasauer.di;
import haxe.Constraints.IMap;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Matthias Auer
 */
class System
{
	private static var mappings:Map<String, Class<Dynamic>> = new Map<String, Class<Dynamic>>();
	private static var instances:Map<String, Dynamic> = new Map<String, Dynamic>();
	
	private function new() 
	{	
	}
	
	public static function register(clazz:Class<Component>, views:Array<Class<ComponentView>>) : Void
	{
		// the basic mapping - it to itself
		registerView(clazz, clazz);
		
		// also map all views
		for (view in views)
		{
			registerView(view, clazz);
		}
	}
	
	private static function registerView(componentView:Class<Dynamic>, component:Class<Component>) : Void
	{
		var viewClazzName = Type.getClassName(componentView);
		
		mappings.set(viewClazzName, component);
	}
	
	public static function clear() {
		// by creating a new instance we lose the old mappings !
		mappings = new Map<String, Class<Dynamic>>();
		instances = new Map<String, Dynamic>();
	}
	
	public static function get<T:ComponentView>(clazz:Class<T>) : T {		
		var clazzName = Type.getClassName(clazz);
		
		// check whether there is a mapping
		if (!mappings.exists(clazzName)) {
			throw "No Component registered for " + clazzName;
		}
		
		// get the clazz that the view is mapped to
		var clazzToInstantiate:Class<Dynamic> = mappings.get(clazzName);
		var clazzToInstantiateClazzName = Type.getClassName(clazzToInstantiate);
		
		// if it doesn't exist
		if (!instances.exists(clazzToInstantiateClazzName)) {
			var newInstance = Type.createInstance(clazzToInstantiate, []);
			
			// instantiate the clazz
			instances.set(clazzToInstantiateClazzName, newInstance);
		}
		
		return instances.get(clazzToInstantiateClazzName);
	}
}