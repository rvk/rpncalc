using Toybox.System;
using Toybox.WatchUi as Ui;

class CalculatorDelegate extends Ui.BehaviorDelegate {
		
	var view;
	
	function initialize(targetView) {
		view = targetView;
		Ui.BehaviorDelegate.initialize();
	}
	
	function onMenu() {
		Ui.pushView(new Rez.Menus.MainMenu(), new MainMenuDelegate(view), Ui.SLIDE_IMMEDIATE);
	}

	function onSelect() {
		if (view.inputActive) {
			view.input.add(view.current);
			view.current = 0;
		} else {
			view.inputActive = true;
		}
		Ui.requestUpdate();
	}
	
	function onBack() {
		Ui.pushView(new Rez.Menus.OpsMenu(), new OpsMenuDelegate(view), Ui.SLIDE_IMMEDIATE);
    	return true;
    }
    
    function hasDot() {
    	for (var i = 0; i < view.input.size(); i += 1) {
    		if (view.input[i].equals(".")) {
    			return true;
    		}
    	}
    	return false;
 	}
 	
    function onNextPage() {
    	view.inputActive = true;
		if (view.current instanceof Number) {
    		if (view.current > 0) {
    			view.current -= 1;
    		} else {
    			if (!hasDot()) {
    				view.current = ".";
    			} else {
    				view.current = 9;
    			}
    		}
    	} else {
    		view.current = 9;
    	}
  		Ui.requestUpdate();
  		return true;
    }
    
    function onPreviousPage() {
    	view.inputActive = true;
    	if (view.current instanceof Number) {
    		if (view.current < 9) {
    			view.current += 1;
    		} else {
    			if (!hasDot()) {
    				view.current = ".";
    			} else {
    				view.current = 0;
    			}
    		}
    	} else {
    		view.current = 0;
    	}
  		Ui.requestUpdate();
  		return true;
    }
}