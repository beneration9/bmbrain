package bmbrain;
#if threeds
@:cppFileCode(
    '#include <citro2d.h>
    C3D_RenderTarget* top = C2D_CreateScreenTarget(GFX_TOP, GFX_LEFT);

    void gfxInitForFucksSake() {
        C3D_Init(C3D_DEFAULT_CMDBUF_SIZE);
	    C2D_Init(C2D_DEFAULT_MAX_OBJECTS);
	    C2D_Prepare();
    }
    void beginTheFuckingFrame() {
        C3D_FrameBegin(C3D_FRAME_SYNCDRAW);
    }
    void endTheFuckingFrame() {
        C3D_FrameEnd(0);
    }
    void clearTheFuckingScreen() {
        C2D_TargetClear(top, C2D_Color32(0, 0, 0, 255));
    }
    void beginTheFuckingScene() {
        C2D_SceneBegin(top);
    }'
)

class Graphics {
    public static function gfxInit() {
        untyped __cpp__('gfxInitForFucksSake()');
    }

    public static function C3D_FrameBegin() {
        untyped __cpp__('beginTheFuckingFrame()');
    }

    public static function C3D_FrameEnd() {
        untyped __cpp__('endTheFuckingFrame()');
    }
    
    public static function clear() {
        untyped __cpp__('clearTheFuckingScreen()');
    }

    public static function sceneBegin() {
        untyped __cpp__('beginTheFuckingScene()');
    }
}
#end