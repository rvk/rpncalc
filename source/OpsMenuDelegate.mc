using Toybox.WatchUi as Ui;

class OpsMenuDelegate extends Ui.MenuInputDelegate {

	var view;
	
	function initialize(targetView) {
		view = targetView;
		MenuInputDelegate.initialize();
	}
	
	function onMenuItem(item) {
		var tmp;
		if (item == :enter && !view.inputActive) {
				tmp = view.pop();
				view.push(tmp);
				view.push(tmp);
		}
		view.addInputToStack();
		if (item == :clear) {
			if (view.pop() == 0) {
				view.pop();
			}
		} else if (item == :swap) {
			view.swap();
		} else if (item == :invert) {
			view.push(view.pop() * -1);
		} else if (item == :add) {
			view.push(view.pop() + view.pop());
		} else if (item == :subtract) {
			tmp = view.pop();
			view.push(view.pop() - tmp);
		} else if (item == :multiply) {
			view.push(view.pop() * view.pop());
		} else if (item == :divide) {
			tmp = view.pop();
			if (tmp != 0) {
				view.push(view.pop() / tmp);
			}
		}
	}
}