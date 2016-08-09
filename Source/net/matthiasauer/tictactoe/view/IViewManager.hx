package net.matthiasauer.tictactoe.view;
import net.matthiasauer.di.IComponentView;
import openfl.display.Sprite;

/**
 * ...
 * @author Matthias Auer
 */
interface IViewManager extends IComponentView
{
	function initialize(parent:Sprite) : Void;
}