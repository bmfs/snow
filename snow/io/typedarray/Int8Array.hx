package snow.io.typedarray;

#if js

    @:forward
    @:arrayAccess
    abstract Int8Array(js.html.Int8Array)
        from js.html.Int8Array
        to js.html.Int8Array {

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {
            if(elements != null) {
                this = new js.html.Int8Array( elements );
            } else if(array != null) {
                this = new js.html.Int8Array( untyped array );
            } else if(view != null) {
                this = new js.html.Int8Array( untyped view );
            } else if(buffer != null) {
                len = (len == null) ? untyped __js__('undefined') : len;
                this = new js.html.Int8Array( buffer, byteoffset, len );
            } else {
                this = null;
            }
        }

        @:arrayAccess inline function __set(idx:Int, val:UInt) return this[idx] = val;
        @:arrayAccess inline function __get(idx:Int) : UInt return this[idx];

    }

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Int8Array(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 1;

        public var length (get, never):Int;

        public inline function new(
            ?elements:Int,
            ?array:Array<Float>,
            ?view:ArrayBufferView,
            ?buffer:ArrayBuffer, ?byteoffset:Int = 0, ?len:Null<Int>
        ) {

            if(elements != null) {
                this = new ArrayBufferView( elements, Int8 );
            } else if(array != null) {
                this = new ArrayBufferView(0, Int8).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Int8).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Int8).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Int8Array";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Int8Array return this.subarray(begin, end);

    //Internal

        inline function get_length() return this.length;


        @:noCompletion
        @:arrayAccess
        public inline function __get(idx:Int) {
            return ArrayBufferIO.getInt8(this.buffer, this.byteOffset+idx);
        }

        @:noCompletion
        @:arrayAccess
        public inline function __set(idx:Int, val:Int) {
            return ArrayBufferIO.setInt8(this.buffer, this.byteOffset+idx, val);
        }

    }

#end //!js
