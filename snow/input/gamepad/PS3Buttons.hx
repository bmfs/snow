package snow.input.gamepad;

import snow.input.gamepad.Gamepad;

class PS3Buttons
{

#if snow_web

	public static var cross:Int = 14;
	public static var circle:Int = 13;
	public static var square:Int = 15;
	public static var triangle:Int = 12;
	public static var r1:Int = 11;
	public static var l1:Int = 10;

	public static var dpad_up:Int = 4;
	public static var dpad_down:Int = 6;
	public static var dpad_right:Int = 5;
	public static var dpad_left:Int = 7;

	public static var left_analog:Int = 1;
	public static var right_analog:Int = 2;

	public static var ps:Int = 16;
	public static var select:Int = 0;
	public static var start:Int = 3;

	public static var right_trigger:Int = 5;
	public static var left_trigger:Int = 4;

	public static var right_analog_stick:GamepadAxis = { x: 2, y: 3 };
	public static var left_analog_stick:GamepadAxis = { x: 0, y: 1 };


#else

	public static var cross:Int = 0;
	public static var circle:Int = 1;
	public static var square:Int = 2;
	public static var triangle:Int = 3;
	public static var r1:Int = 10;
	public static var l1:Int = 9;

	public static var dpad_up:Int = 11;
	public static var dpad_down:Int = 12;
	public static var dpad_right:Int = 14;
	public static var dpad_left:Int = 13;

	public static var left_analog:Int = 7;
	public static var right_analog:Int = 8;

	public static var ps:Int = 5;
	public static var select:Int = 4;
	public static var start:Int = 6;

	public static var right_trigger:Int = 5;
	public static var left_trigger:Int = 4;

	public static var right_analog_stick:GamepadAxis = { x: 2, y: 3 };
	public static var left_analog_stick:GamepadAxis = { x: 0, y: 1 };


#end
}
