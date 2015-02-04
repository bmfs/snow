package snow.io.typedarray;

#if js

    typedef Int32Array = js.html.Int32Array;

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Int32Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 4;

        public var length (get, never):Int;

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Int32 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Int32).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Int32).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Int32).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Int32Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Int32Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getInt32(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:Int) {
            return ArrayBufferIO.setInt32(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        }

    }

#end //!js
