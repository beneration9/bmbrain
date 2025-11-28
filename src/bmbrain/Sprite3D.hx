package bmbrain;
import bmbrain.ThreeDMath;
import bmbrain.Sprite;

class Sprite3D extends Sprite {
    public var pos:{ x: Float, y: Float, z: Float }
    public function new(x:Float, y:Float, z:Float, path:String, active:String, delay:Float) {
        this.pos = { x: x, y: y, z: z };
        super(0, 0, path, active, delay, 1);
    }

    public override function draw(dt:Float) {
        drawSorted();
    }

    public function drawSorted() {
        ThreeDMath.sort(this);
    }

    public function realDraw(dt:Float) {
        var newStuff = ThreeDMath.project(this.pos.x, this.pos.y, this.pos.z);
        this.x = newStuff.x;
        this.y = newStuff.y;
        this.scale = newStuff.scale;
        super.draw(dt);
    }
}