package snow.io.typedarray;

import snow.io.typedarray.ArrayBufferView;
import snow.io.typedarray.TypedArrayType;

@:forward()
@:arrayAccess
abstract Float64Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

    public inline static var BYTES_PER_ELEMENT : Int = 8;

    public var length (get, never):Int;

    public inline function new( elements:Int )
        this = new ArrayBufferView( elements, Float64 );

    public static inline function fromArray( array:Array<Float> ) : Float64Array
        return new Float64Array(0).initArray( array );

    public static inline function fromBuffer( buffer:ArrayBuffer, ? byteOffset:Int = 0, count:Null<Int> = null ) : Float64Array
        return new Float64Array(0).initBuffer( buffer, byteOffset, count );

    public static inline function fromTypedArray( view:ArrayBufferView ) : Float64Array
        return new Float64Array(0).initTypedArray( view );

//Public API

        //still busy with this
    public inline function subarray( begin:Int, end:Null<Int> = null) : Float64Array return this.subarray(begin, end);

//Compatibility

#if js
    @:from static function fromArrayBufferView(a:js.html.ArrayBufferView) {
        switch(untyped a.constructor) {
            case js.html.Float64Array:
                return new Float64Array(0).initTypedArray(untyped a);
            case _: return throw "wrong type";
        }
    }
    @:from static function fromFloat64Array(a:js.html.Float64Array)
        return new Float64Array(0).initTypedArray(untyped a);

    @:to function toArrayBufferView(): js.html.ArrayBufferView
        return untyped this.buffer.b;
    @:to function toFloat64Array(): js.html.Float64Array
        return untyped this.buffer.b;
#end

//Internal

    inline function get_length() return this.length;


    @:noCompletion
    @:arrayAccess
    public inline function __get(idx:Int) : Float {
        #if js
        untyped return (untyped this.buffer.b)[(this.byteOffset/BYTES_PER_ELEMENT)+idx];
        #else
        return ArrayBufferIO.getFloat64(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        #end
    }

    @:noCompletion
    @:arrayAccess
    public inline function __set(idx:Int, val:Float) : Float {
        #if js
        untyped return (untyped this.buffer.b)[(this.byteOffset/BYTES_PER_ELEMENT)+idx] = val;
        #else
        return ArrayBufferIO.setFloat64(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        #end
    }

}
