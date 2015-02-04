package snow.platform.native;

@:cppFileCode( 'extern "C" void snow_register_prims();')
@:buildXml("
<set name='SNOW_PATH' value='${haxelib:snow}'/>
<set name='MSVC_LIB_VERSION' value='-${MSVC_VER}' if='windows'/>
<set name='DEBUG_SNOW' value='${DBG}' if='debug_snow'/>
<include name='${SNOW_PATH}/project/include.link.app.xml'/>
<target id='haxe'>
  <lib name='${SNOW_PATH}/ndll/${BINDIR}/libsnow${DEBUG_SNOW}${LIBEXTRA}${LIBEXT}'/>
</target>
")

@:keep class StaticSnow {
    static function __init__() {
        untyped __cpp__("snow_register_prims();");
    } //__init__
} //StaticSnow

