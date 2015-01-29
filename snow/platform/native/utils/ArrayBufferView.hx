package snow.platform.native.utils;

using snow.platform.native.utils.ArrayBufferViewIO;
import snow.utils.TypedArrayType;

/**
    Copyright Sven Bergström 2014
    Created for snow https://github.com/underscorediscovery/snow
    License MIT
**/

class ArrayBufferView {

    public var type = TypedArrayType.None;
    public var BYTES_PER_ELEMENT (default,null): Int = 1;
    public var buffer:ArrayBuffer;
    public var byteOffset:Int;
    public var length:Int;


    @:allow(snow.platform.native.utils)
    inline function new(in_type:TypedArrayType) {

        type = in_type;

        BYTES_PER_ELEMENT =
            switch(type) {
                case Int8:          1;
                case UInt8:         1;
                case UInt8Clamped:  1;
                case Int16:         2;
                case UInt16:        2;
                case Int32:         4;
                case UInt32:        4;
                case Float32:       4;
                case _: 1;
            };

    } //new

//Public APIs

    @:allow(snow.platform.native.utils)
    inline function set<T_arr>( ?view:ArrayBufferView, ?array:Array<T_arr>, ?offset:Int = 0) : Void {

        if(view != null && array == null) {
            buffer.blit( to_byte_len(offset), view.buffer, view.byteOffset, view.buffer.byteLength );
        } else if(array != null) {
            setFromArray(array, offset);
        } // view != null

    } //set

//Internal TypedArray api

    @:allow(snow.platform.native.utils)
    @:generic inline function subarray<T_subarray>( begin:Int, end:Null<Int> = null ) : T_subarray {

        if (end == null) end == length;
        var len = end - begin;
        var byte_offset = to_byte_len(begin);

        var array : ArrayBufferView =
            switch(type) {
                case Int8:          new         Int8Array(buffer, byte_offset, len);
                case Int16:         new        Int16Array(buffer, byte_offset, len);
                case Int32:         new        Int32Array(buffer, byte_offset, len);
                case UInt8:         new        UInt8Array(buffer, byte_offset, len);
                case UInt16:        new       UInt16Array(buffer, byte_offset, len);
                case UInt32:        new       UInt32Array(buffer, byte_offset, len);
                case Float32:       new      Float32Array(buffer, byte_offset, len);
                case UInt8Clamped:  new UInt8ClampedArray(buffer, byte_offset, len);

                case None: null;
                case _: null;
            }

        return cast array;

    } //subarray

        //cannot inline this function!
    @:allow(snow.platform.native.utils)
    @:generic function construct<T_construct>( cn_opt:T_construct, byte_offset:Int = 0, len:Null<Int> = null) {

        if( Std.is(cn_opt,Int) ) {

            create_from_length(cast cn_opt);

        } else {

            switch( Type.getClass(cn_opt) ) {

                case ArrayBuffer:
                    create_from_buffer(cast cn_opt, byte_offset, len);

                case ArrayBufferView:
                    create_from_typedarray(cast cn_opt);

                case Array:
                    create_from_array(cast cn_opt);

                default: throw "Invalid Arguments for new " + this.type;

            } //switch

        } //is Int

    } //construct

    @:allow(snow.platform.native.utils)
    inline function create_from_length( len:Int ) {

        if(len < 0) len = 0;
        var byte_len = to_byte_len(len);

            //:note:spec: also has
        //len = min(len,maxint);

        byteOffset = 0;
        length = len;
        buffer = new ArrayBuffer( byte_len );

    } //(length)

    @:allow(snow.platform.native.utils)
    inline function create_from_typedarray( view:ArrayBufferView ) {

        var viewByteLength = view.buffer.byteLength;
        var srcByteOffset = view.byteOffset;
        var srcLength = viewByteLength - srcByteOffset;
        var cloneLength = srcLength - srcByteOffset;

            //new storage
        buffer = new ArrayBuffer(cloneLength);
        byteOffset = 0;
        length = view.length;

            //same species, so just blit the data
            //in other words, it shares the same bytes per element etc
        if(view.type == type) {

            buffer.blit( 0, view.buffer, srcByteOffset, cloneLength );

        } else {

            throw "UnimplementedError: data type conversion from TypedArray is pending";

        } //type != type

    } //(typedArray)

    @:allow(snow.platform.native.utils)
    inline function create_from_buffer( in_buffer:ArrayBuffer, ?in_byteOffset:Int = 0, len:Null<Int> = null ) {

        if(in_byteOffset < 0)
            throw 'RangeError: byteOffset < 0, given:$in_byteOffset';
        if(in_byteOffset % BYTES_PER_ELEMENT != 0)
            throw 'RangeError: byteOffset must be divisible by element size($BYTES_PER_ELEMENT)';

        var bufferByteLength = in_buffer.byteLength;
        var newByteLength = bufferByteLength;

        if( len == null ) {

            newByteLength = bufferByteLength - in_byteOffset;

            if(bufferByteLength % BYTES_PER_ELEMENT != 0)
                throw 'RangeError: given buffer byteLength is not divisible by element size($BYTES_PER_ELEMENT), given:$bufferByteLength';
            if(newByteLength < 0)
                throw 'RangeError: byte length from byteOffset would become negative';

        } else {

            newByteLength = len * BYTES_PER_ELEMENT;

            var newRange = in_byteOffset + newByteLength;
            if( newRange > bufferByteLength )
                throw 'RangeError: range from byteOffset+len out of range (given byte range=`$newRange`, buffer byteLength=`$bufferByteLength`';

        }

        buffer = in_buffer;
        byteOffset = in_byteOffset;
        length = Std.int(newByteLength / BYTES_PER_ELEMENT);

    } //(buffer [, byteOffset [, length]])


    @:allow(snow.platform.native.utils)
    inline function create_from_array( array:Array<Float> ) {

        buffer = new ArrayBuffer(to_byte_len(array.length));
        byteOffset = 0;
        length = array.length;

        setFromArray(array);

    } //array

    inline function to_byte_len( elem_len:Int ) : Int {

        return elem_len * BYTES_PER_ELEMENT;

    } //length_to_bytelength

} //ArrayBufferView
