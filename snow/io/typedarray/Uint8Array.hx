package snow.io.typedarray;

#if js

    typedef Uint8Array = js.html.Uint8Array;

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Uint8Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 1;

        public var length (get, never):Int;

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Uint8 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Uint8).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Uint8).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Uint8).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Uint8Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Uint8Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getUint8(this.buffer, this.byteOffset+idx);
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:UInt) {
            return ArrayBufferIO.setUint8(this.buffer, this.byteOffset+idx, val);
        }

    }

#end //!js
