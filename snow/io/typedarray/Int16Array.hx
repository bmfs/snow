package snow.io.typedarray;

import snow.io.typedarray.ArrayBufferView;
import snow.io.typedarray.TypedArrayType;

@:forward()
@:arrayAccess
abstract Int16Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

    public inline static var BYTES_PER_ELEMENT : Int = 2;

    public var length (get, never):Int;

    public inline function new( elements:Int )
        this = new ArrayBufferView( elements, Int16 );

    public static inline function fromArray( array:Array<Float> ) : Int16Array
        return new Int16Array(0).initArray(array);

    public static inline function fromBuffer( buffer:ArrayBuffer, ? byteOffset:Int = 0, count:Null<Int> = null ) : Int16Array
        return new Int16Array(0).initBuffer( buffer, byteOffset, count );

    public static inline function fromTypedArray( view:ArrayBufferView ) : Int16Array
        return new Int16Array(0).initTypedArray( view );

//Public API

        //still busy with this
    public inline function subarray( begin:Int, end:Null<Int> = null) : Int16Array return this.subarray(begin, end);

//Compatibility

#if js
    @:from static function fromArrayBufferView(a:js.html.ArrayBufferView) : Int16Array {
        switch(untyped a.constructor) {
            case js.html.Int16Array:
                return new Int16Array(0).initTypedArray(untyped a);
            case _: return throw "wrong type";
        }
    }
    @:from static function fromInt16Array(a:js.html.Int16Array) : Int16Array
        return new Int16Array(0).initTypedArray(untyped a);

    @:to function toArrayBufferView(): js.html.ArrayBufferView
        return untyped this.buffer.b;
    @:to function toInt16Array(): js.html.Int16Array
        return untyped this.buffer.b;
#end

//Internal

    inline function get_length() return this.length;


    @:noCompletion
    @:arrayAccess
    public inline function __get(idx:Int) {
        #if js
        untyped return (untyped this.buffer.b)[(this.byteOffset/BYTES_PER_ELEMENT)+idx];
        #else
        return ArrayBufferIO.getInt16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        #end
    }

    @:noCompletion
    @:arrayAccess
    public inline function __set(idx:Int, val:Int) {
        #if js
        untyped return (untyped this.buffer.b)[(this.byteOffset/BYTES_PER_ELEMENT)+idx] = val;
        #else
        return ArrayBufferIO.setInt16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        #end
    }

}
