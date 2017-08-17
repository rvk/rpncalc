using Toybox.System;
using Toybox.WatchUi as Ui;

class RpnCalcDelegate extends Ui.BehaviorDelegate {
		
	function initialize() {
		Ui.BehaviorDelegate.initialize();
	}
	
	function onSelect() {
		var view = new CalculatorView();
		Ui.pushView(view, new CalculatorDelegate(view), Ui.SLIDE_IMMEDIATE);
	}
}