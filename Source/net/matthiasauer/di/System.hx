package net.matthiasauer.di;
import haxe.Constraints.IMap;
import haxe.ds.ObjectMap;

/**
 * ...
 * @author Matthias Auer
 */
class System implements ISystem
{
	private var mappings:Map<String, Class<Dynamic>>;
	private var instances:Map<String, Dynamic>;
	private var toBeInitialized:Map<String, Bool>;
	
	public function new() 
	{
		mappings = new Map<String, Class<Dynamic>>();
		instances = new Map<String, Dynamic>();
		toBeInitialized = new Map<String, Bool>();
	}
	
	public function register(clazz:Class<Component>, views:Array<Class<ComponentView>>) : Void
	{
		// the basic mapping - it to itself
		registerView(clazz, clazz);
		
		// also map all views
		for (view in views)
		{
			registerView(view, clazz);
		}
	}
	
	public function get<T:ComponentView>(view:Class<T>) : T {
		// get the clazz mapped by the view
		var clazzToInstantiate:Class<Dynamic> = getClazzForView(view);
		
		// get an id for the clazz
		var clazzToInstantiateClazzName:String = Type.getClassName(clazzToInstantiate);
		
		// get an instance of the clazz
		var instance:Dynamic = getInstance(clazzToInstantiateClazzName, clazzToInstantiate);
		
		// make sure it has been initialized
		makeSureInstanceIsInitialized(instance, clazzToInstantiateClazzName);
		
		return instance;
	}
	
	private function registerView(componentView:Class<Dynamic>, component:Class<Component>) : Void
	{
		var viewClazzName = Type.getClassName(componentView);
		
		mappings.set(viewClazzName, component);
	}
	
	private function getClazzForView<T:ComponentView>(clazz:Class<T>) : Class<Dynamic>
	{
		var clazzName = Type.getClassName(clazz);
		
		// check whether there is a mapping
		if (!mappings.exists(clazzName)) {
			throw "No Component registered for " + clazzName;
		}
		
		return mappings.get(clazzName);
	}
	
	private function getInstance(clazzToInstantiateClazzName:String, clazzToInstantiate:Class<Dynamic>):Dynamic {
		// if it doesn't exist
		if (!instances.exists(clazzToInstantiateClazzName)) {
			var newInstance = Type.createInstance(clazzToInstantiate, []);
			
			// instantiate the clazz
			instances.set(clazzToInstantiateClazzName, newInstance);
			
			toBeInitialized.set(clazzToInstantiateClazzName, true);
		}
		
		return instances.get(clazzToInstantiateClazzName);
	}
	
	private function makeSureInstanceIsInitialized(instance:Dynamic, clazzToInstantiateClazzName:String) : Void {
		if (toBeInitialized.remove(clazzToInstantiateClazzName))
		{
			// initialize the component - exactly once !
			instance.initializeComponent(this);
		}
	}
}