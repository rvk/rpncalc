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
				view.push(view.pop().toDouble() / tmp);
			}
		} else if (item == :sqrt) {
			view.push(Math.sqrt(view.pop()));
		} else if (item == :power) {
			tmp = view.pop();
			view.push(Math.pow(tmp, view.pop()));
		} else if (item == :log) {
			tmp = view.pop();
			view.push(Math.log(tmp, view.pop()));
		} else if (item == :log10) {
			view.push(Math.log(view.pop(), 10));
		} else if (item == :trigonometry) {
			Ui.pushView(new Rez.Menus.TrigonometryMenu(), self, Ui.SLIDE_IMMEDIATE);
		} else if (item == :pi) {
			view.addValueToStack(Math.PI);
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :sin) {
			view.push(Math.sin(toRadians(view.pop())));
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :cos) {
			view.push(Math.cos(toRadians(view.pop())));
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :tan) {
			view.push(Math.tan(toRadians(view.pop())));
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :asin) {
		    view.push(fromRadians(Math.asin(view.pop())));
		    Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :acos) {
		    view.push(fromRadians(Math.acos(view.pop())));
		    Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :atan) {
		    view.push(fromRadians(Math.atan(view.pop())));
		    Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :degrad) {
			view.push(Math.toRadians(view.pop()));
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :raddeg) {
			view.push(Math.toDegrees(view.pop()));
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		}
	}
	
	function toRadians(angle) {
		if (view.angleMode.equals("RAD")) {
			return angle;
		}
		return Math.toRadians(angle);
	}
	
	function fromRadians(angle) {
		if (view.angleMode.equals("RAD")) {
			return angle;
		}
		return Math.toDegrees(angle);
	}
}