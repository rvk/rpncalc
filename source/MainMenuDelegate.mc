using Toybox.WatchUi as Ui;

class MainMenuDelegate extends Ui.MenuInputDelegate {

	var view;
	
	function initialize(targetView) {
		view = targetView;
		MenuInputDelegate.initialize();
	}
	
	function onMenuItem(item) {
		if (item == :exit) {
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :angle) {
			Ui.pushView(new Rez.Menus.AngleMenu(), self, Ui.SLIDE_IMMEDIATE);
		} else if (item == :deg) {
			view.setAngleMode("DEG");
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		} else if (item == :rad) {
			view.setAngleMode("RAD");
			Ui.popView(Ui.SLIDE_IMMEDIATE);
		}
	}
}