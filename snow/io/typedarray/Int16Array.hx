package snow.io.typedarray;

#if js

    typedef Int16Array = js.html.Int16Array;

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Int16Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 2;

        public var length (get, never):Int;

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Int16 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Int16).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Int16).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Int16).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Int16Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Int16Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getInt16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT));
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:Int) {
            return ArrayBufferIO.setInt16(this.buffer, this.byteOffset+(idx*BYTES_PER_ELEMENT), val);
        }

    }

#end //!js