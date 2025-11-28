package bmbrain;
class ThreeDMath {
    static var distance:Float = 300;
    static var nearClip:Float = 1;

    public static var camX:Float = 0;
    public static var camY:Float = 175;
    public static var camZ:Float = 0;

    static var list:Array<Sprite3D> = [];

    public static function project(x:Float, y:Float, z:Float):{ x:Float, y:Float, scale:Float } {
        var dz = z + camZ + distance;
        if (dz < nearClip) 
            return { x : -10000, y : -10000, scale : 1 };
        return {
            x: (x + camX) * (distance / dz),
            y: (y + camY) * (distance / dz),
            scale: distance / dz
        };
    }

    public static function sort(obj:Sprite3D) {
        var i = 0;
        while(i < list.length) {
            if (obj.pos.z > list[i].pos.z) {
                list.insert(i, obj);
                return;
            }
            i++;
        }
        list.push(obj);
    }

    public static function draw3D(dt:Float) {
        for (obj in list) {
            obj.realDraw(dt);
        }
        list = [];
    }
}