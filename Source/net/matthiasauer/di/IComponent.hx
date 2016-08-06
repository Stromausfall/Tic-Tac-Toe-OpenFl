package net.matthiasauer.di;

/**
 * @author Matthias Auer
 */
interface IComponent 
{
	function initializeComponent(system:ISystem) : Void;
}