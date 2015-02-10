package snow.input.gamepad;

import snow.input.gamepad.Gamepad;

class XBox360Buttons
{

#if snow_web

	public static var button_a:Int = 0;
	public static var button_b:Int = 1;
	public static var button_x:Int = 2;
	public static var button_y:Int = 3;
	public static var rb:Int = 5;
	public static var lb:Int = 4;
	public static var dpad_up:Int = 11;
	public static var dpad_down:Int = 12;
	public static var dpad_right:Int = 14;
	public static var dpad_left:Int = 13;

	public static var left_analog:Int = 6;
	public static var right_analog:Int = 7;

	public static var xbox:Int = 10;
	public static var back:Int = 9;
	public static var start:Int = 8;

	public static var right_trigger:Int = 5;
	public static var left_trigger:Int = 4;

	public static var right_analog_stick:GamepadAxis = { x: 2, y: 3 };
	public static var left_analog_stick:GamepadAxis = { x: 0, y: 1 };


#else

	public static var button_a:Int = 0;
	public static var button_b:Int = 1;
	public static var button_x:Int = 2;
	public static var button_y:Int = 3;
	public static var rb:Int = 10;
	public static var lb:Int = 9;
	public static var dpad_up:Int = 11;
	public static var dpad_down:Int = 12;
	public static var dpad_right:Int = 14;
	public static var dpad_left:Int = 13;

	public static var left_analog:Int = 7;
	public static var right_analog:Int = 8;

	public static var xbox:Int = 5;
	public static var back:Int = 4;
	public static var start:Int = 6;

	public static var right_trigger:Int = 5;
	public static var left_trigger:Int = 4;

	public static var right_analog_stick:GamepadAxis = { x: 2, y: 3 };
	public static var left_analog_stick:GamepadAxis = { x: 0, y: 1 };

#end
}
