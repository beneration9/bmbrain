package bmbrain;
import bmbrain.Obj;

class Scene extends Obj {
    public var objects:Array<Obj>;

    public function new(path:String) {
        this.objects = [];
        var lines = "";
        
        #if threeds
        untyped __cpp__('FILE* file = fopen(path.c_str(), "r");');
        untyped __cpp__('char buffer[1024];
        size_t bytesRead;
        while ((bytesRead = fread(buffer, 1, sizeof(buffer), file)) > 0) {
            lines.append(buffer, bytesRead);
        }');
        #end

        for (line in lines.split("\n")) {
            var splitted = line.split("?");
            switch (splitted[0]) {
                case "Sprite3D":
                    var obj = new Sprite3D(Std.parseFloat(splitted[3]), Std.parseFloat(splitted[4]), Std.parseFloat(splitted[5]), splitted[1], splitted[2], Std.parseInt(splitted[3]));
                    this.objects.push(obj);
                // case "Player":
                //     var obj = new Player(Std.parseFloat(splitted[1]), Std.parseFloat(splitted[2]), Std.parseFloat(splitted[3]));
                //     this.objects.push(obj);
                default:
                    
            }
        }
    }

    public override function start() {
        for (obj in this.objects) {
            obj.start();
        }
    }

    public override function frame() {
        for (obj in this.objects) {
            obj.frame();
        }
    }

    public override function draw(dt:Float) {
        for (obj in this.objects) {
            obj.draw(dt);
        }
    }
}