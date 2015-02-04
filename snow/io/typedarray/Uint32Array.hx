package snow.io.typedarray;

#if js

    typedef Uint32Array = js.html.Uint32Array;

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Uint32Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 4;

        public var length (get, never):Int;

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Uint32 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Uint32).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Uint32).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Uint32).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Uint32Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Uint32Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getUint32(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:UInt) {
            return ArrayBufferIO.setUint32(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        }

    }

#end //!js
