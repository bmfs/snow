package snow.io.typedarray;

#if js

    typedef Uint8ClampedArray = js.html.Uint8ClampedArray;

#else

    import snow.io.typedarray.ArrayBufferView;
    import snow.io.typedarray.TypedArrayType;

    @:forward()
    @:arrayAccess
    abstract Uint8ClampedArray(ArrayBufferView) from ArrayBufferView to ArrayBufferView {

        public inline static var BYTES_PER_ELEMENT : Int = 1;

        public var length (get, never):Int;

        public inline function new( ?elements:Int, ?array:Array<Float>, ?view:ArrayBufferView, ?buffer:ArrayBuffer, ?byteoffset:Int, ?len:Int ) {
            if(elements != null) {
                this = new ArrayBufferView( elements, Uint8Clamped );
            } else if(array != null) {
                this = new ArrayBufferView(0, Uint8Clamped).initArray(array);
            } else if(view != null) {
                this = new ArrayBufferView(0, Uint8Clamped).initTypedArray(view);
            } else if(buffer != null) {
                this = new ArrayBufferView(0, Uint8Clamped).initBuffer(buffer, byteoffset, len);
            } else {
                throw "Invalid constructor arguments for Uint8ClampedArray";
            }
        }

    //Public API

            //still busy with this
        public inline function subarray( begin:Int, end:Null<Int> = null) : Uint8ClampedArray return this.subarray(begin, end);

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
            return ArrayBufferIO.setUint8Clamped(this.buffer, this.byteOffset+idx, val);
        }


    }

#end //!js
