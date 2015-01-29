package snow.platform.native.utils;

/**
    Copyright Sven Bergström 2014
    Created for snow https://github.com/underscorediscovery/snow
    License MIT
**/

import snow.platform.native.utils.ArrayBufferView;
import snow.utils.TypedArrayType;

using snow.platform.native.utils.ArrayBufferViewIO;


@:forward()
@:arrayAccess
abstract Int8Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

    public var length (get, never):Int;

    @:generic
    public inline function new<T_i8_new>( opt:T_i8_new, byteOffset:Int = 0, len:Null<Int> = null) {

        this = new ArrayBufferView( TypedArrayType.Int8 );
        this.construct(opt, byteOffset, len);

    } //new

//Public API

        //this is required to determine the underlying type in ArrayBufferView
    public function subarray( begin:Int, end:Null<Int> = null) : Int8Array return this.subarray(begin, end);
    public function set( ?view:ArrayBufferView, ?array:Array<Int>, ?offset:Int = 0) return this.set(view, cast array, offset);

//Internal

    function get_length() return this.length;

    @:noCompletion @:arrayAccess
    public inline function __get(idx:Int) return this.getInt8(idx);
    @:noCompletion @:arrayAccess
    public inline function __set(idx:Int, val:Int) return this.setInt8(idx, val);

} //Int8Array
