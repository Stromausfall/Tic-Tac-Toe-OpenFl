package net.matthiasauer.di;

/**
 * ...
 * @author Matthias Auer
 */
class SystemForMocks extends System
{
	public function registerMock<T:Component>(originalClass : Class<T>, mock : T)
	{
		// get an id for the clazz
		var clazzToInstantiateClazzName:String = Type.getClassName(originalClass);
		
		// register the instance and note that we don't need to initialize it
		this.instances.set(clazzToInstantiateClazzName, mock);
		this.toBeInitialized.remove(clazzToInstantiateClazzName);
	}
}