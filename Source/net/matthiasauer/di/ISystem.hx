package net.matthiasauer.di;

/**
 * ...
 * @author Matthias Auer
 */
interface ISystem
{
	/**
	 * Registers a class and the views it implements
	 * @param	clazz the clazz for which an instancet should be offered by the system
	 * @param	views the views (as well as the class itself) using which the instance should be retrievable
	 */
	function register(clazz:Class<IComponent>, views:Array<Class<IComponentView>>) : Void;
	
	/**
	 * Returns the unique instance that offers the view given as argument
	 */
	function get<T:IComponentView>(view:Class<T>) : T;
}