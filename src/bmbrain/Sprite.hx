package bmbrain;
import bmbrain.Obj;

#if threeds
import cxx.Char;
import cxx.Const;
#end

#if flixel
import flixel.FlxSprite;
import lime.utils.Assets;
#end

#if threeds
@:cppFileCode('C2D_Sprite getSpr(std::string sheetPath, int i) {
    C2D_Sprite spr;
    C2D_SpriteFromSheet(&spr, C2D_SpriteSheetLoad(sheetPath.c_str()), i);
    C2D_SpriteSetCenter(&spr, 0.5f, 0.5f);
    return spr;
}')
#end
class Sprite extends Obj {
    public var x:Float;
    public var y:Float;
    public var scale:Float;
    #if threeds
    private var spritesheets:Map<String, Array<C2D_Sprite>>;
    #end
    #if flixel
    private var spritesheets:Map<String, FlxSprite>;
    #end
    private var activeSheet:String;
    public var frm:Int;
    public var delay:Float;
    private var delayCounter:Float;

    public function new(x:Float, y:Float, path:String, active:String, delay:Float, scale:Float) {
        this.x = x;
        this.y = y;
        this.scale = scale;
        this.activeSheet = active;
        #if threeds
        this.spritesheets = new Map<String, Array<C2D_Sprite>>();
        #end

        #if flixel
        this.spritesheets = new Map<String, FlxSprite>();
        #end

        this.frm = 0;
        this.delay = delay;
        this.delayCounter = 0;

        #if threeds
        path = "romfs:/"+path;
        untyped __cpp__('FILE* file = fopen(path.c_str(), "r");');
        var lines = "";
        untyped __cpp__('char buffer[1024];
        size_t bytesRead;
        while ((bytesRead = fread(buffer, 1, sizeof(buffer), file)) > 0) {
            lines.append(buffer, bytesRead);
        }');

        for (line in lines.split("\n")) {
            var splitted = line.split("?");

            var sprArr:Array<C2D_Sprite> = [];
            for (i in 0...Std.parseInt(splitted[2])) {
                var spr:C2D_Sprite = spr("romfs:/"+splitted[1]+".t3x", i);
                sprArr.push(spr);
            }

            this.spritesheets.set(splitted[0], sprArr);
        }
        #end

        #if flixel
        path = "assets/data/bmbrain/"+path;
        var lines = Assets.getText(path);
        for (line in lines.split("\n")) {
            var splitted = line.split("?");

            var spr:FlxSprite = new FlxSprite();
            for (i in 0...Std.parseInt(splitted[2])) {
                spr.loadGraphic("assets/images/bmbrain/"+splitted[1]+".png");
                var indices = [];
                 for (j in 0...Std.parseInt(splitted[2])) {
                    indices.push(j);
                }
                spr.animation.addByIndices(splitted[0], splitted[0], indices, ".png");
            }

            this.spritesheets.set(splitted[0], spr);
        }
        #end
    }

    public override function draw(dt:Float) {
        #if threeds
        var sprArr = this.spritesheets.get(this.activeSheet);


        if (this.frm >= sprArr.length) {
            this.frm = 0;
        }
        
        var spr = sprArr[this.frm];

        untyped __cpp__("C2D_SpriteSetPos(&spr, this->x, this->y)");
        untyped __cpp__("C2D_SpriteSetScale(&spr, this->scale, this->scale)");
        untyped __cpp__("C2D_DrawSprite(&spr)");

        this.delayCounter += dt;
        if (this.delayCounter < this.delay) {
            return;
        }
        this.delayCounter = 0;
        this.frm++;
        #end

        #if flixel
        var spr = this.spritesheets.get(this.activeSheet);
        spr.x = this.x;
        spr.y = this.y;
        spr.draw();
        #end
    }
    
    #if threeds
    static function spr(sp:String, i:Int):C2D_Sprite {
        return untyped __cpp__('getSpr(sp, i)');
    }
    #end
}

#if threeds
@:const @:native("C2D_Sprite")
extern class C2D_Sprite {}
#end