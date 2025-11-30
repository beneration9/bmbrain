package bmbrain;

#if flixel
import bmbrain.Scene;
import bmbrain.ThreeDMath;
import flixel.FlxSprite;


class FlxBMScene extends FlxSprite
{
	public var scene:Scene;

	public var dt:Float = 0;

	public function new(scn:Scene)
	{
		super();
		this.scene = scn;
		ThreeDMath.camX = 0;
		ThreeDMath.camY = 0;
		ThreeDMath.camZ = 0;
	}

	public static function fromPath(path:String):FlxBMScene
	{
		var scn = new Scene(path);
		return new FlxBMScene(scn);
	}

	override public function update(elapsed:Float):Void
	{
		super.update(elapsed);
		this.scene.frame();
		dt = elapsed;
	}

	override public function draw():Void
	{
		super.draw();
		this.scene.draw(dt);
		ThreeDMath.draw3D(dt);
	}
}
#end