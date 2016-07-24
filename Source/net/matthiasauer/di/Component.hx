package net.matthiasauer.di;

/**
 * @author Matthias Auer
 */
interface Component 
{
	function initializeComponent(system:ISystem) : Void;
}