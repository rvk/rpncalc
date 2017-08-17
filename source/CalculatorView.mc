using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class CalculatorView extends Ui.View {
	
	    var numberWidth = 9;
    	var numberHeight = 22;
    	
    	var stack = [];
    	var input = [];
    	var current = 0;
    	var inputActive = true;
    	
    function initialize() {
        View.initialize();
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
		// Draw stack
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();
        var inputOffset = numberHeight;
        if (inputActive) {
        	inputOffset = 0;
        	for (var i = 0; i < input.size(); i += 1) {
        		dc.drawText(196 - input.size() * numberWidth + numberWidth * i, 150, Gfx.FONT_TINY, input[i], Gfx.TEXT_JUSTIFY_RIGHT);
        	}
        	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        	dc.drawText(196, 150, Gfx.FONT_TINY, current, Gfx.TEXT_JUSTIFY_RIGHT);
        	dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        }
        for (var i = 0; i < stack.size() && i < 5; i += 1) {
        	dc.drawText(196, 128 - numberHeight * i + inputOffset, Gfx.FONT_TINY, format(stack[i]), Gfx.TEXT_JUSTIFY_RIGHT);
        }
        
        
        // Call the parent onUpdate function to redraw the layout
        //View.onUpdate(dc);
        
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function format(number) {
    	var asLong = Math.round(number * 1000000).toLong();
    	var intPart = asLong / 1000000;
    	var fracPart = asLong % 1000000;
    	var fracStr = fracPart.format("%06d");
    	var fracChrs = fracStr.toCharArray();
    	var lastNonZero = -1;
    	for (var i = 0; i < fracChrs.size(); i += 1) {
    		if (!fracChrs[i].equals('0')) {
    			lastNonZero = i;
    		}
    	}
    	if (lastNonZero == -1) {
    		return intPart.toString();
    	} else {
    		return intPart.toString() + "." + fracStr.substring(0, lastNonZero + 1);
    	}	
    }
 /*   
    function format(number) {
    	var intPart = number.toLong().toDouble();
    	if (intPart.equals(number)) {
    		return intPart.toLong().toString();
    	}
    	var tmpStr = number.format("%19.7f");
    	var chars = tmpStr.toCharArray();
    	var firstNumber = -1;
    	var lastNonZero = 0;
    	for (var i = 0; i < chars.size(); i += 1) {
    		if (firstNumber == -1 && !chars[i].equals(' ')) {
    			firstNumber = i;
    		}
    		if (!chars[i].equals('0')) {
    			lastNonZero = i;
    		}
    	}	
    	System.println("lastNonZero idx for " + tmpStr + " is " + lastNonZero + " and first is " + firstNumber);
		return tmpStr.substring(firstNumber, lastNonZero + 1);
	} */
	
    function addInputToStack() {
    	if (inputActive) {
			var str = "";
		
			for (var i = 0; i < input.size(); i += 1) {
				str = str + input[i];
			}
			str = str + current;
			addValueToStack(str.toFloat()); // String.toDouble() doesn't exist
			input = [];
			current = 0;
			inputActive = false;
		}
	}
	
	function addValueToStack(value) {
		var tmpStack = [];
		tmpStack.add(value);
		tmpStack.addAll(stack);
		stack = tmpStack;
		Ui.requestUpdate();
	}
	
	function pop() {
		var result = 0f;
		if (stack.size() > 0) {
			result = stack[0];
			stack.remove(stack[0]);
		}
		return result;
		Ui.requestUpdate();
	}

	function push(value) {
		addValueToStack(value);
	}
	
	function swap() {
		if (stack.size() >= 2) {
			var tmpStack = [];
			tmpStack.add(stack[1]);
			tmpStack.add(stack[0]);
			if (stack.size() > 2) {
				tmpStack.addAll(stack.slice(2, stack.size()));
			}
			stack = tmpStack;
		}
	}
}
