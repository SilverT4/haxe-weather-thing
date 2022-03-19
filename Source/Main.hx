package;

import lime.app.Application;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxState;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.system.Capabilities;

class Main extends Sprite
{
	var gameWidth:Int = 1024;
	var gameHeight:Int = 768;
	var framerate:Int = 90;
	var skipSplash:Bool = false;
	var zoom:Float = -1;
	var startFullscreen:Bool = false;
	public static var fpsVar:FPS;
	var initialState:Class<FlxState> = LaunchState;

	public static function main():Void {
		Lib.current.addChild(new Main());
	}
	public function new()
	{
		super();
		if (stage != null)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE, init);
			}
	}

	private function init(?E:Event):Void
		{
			if (hasEventListener(Event.ADDED_TO_STAGE))
			{
				removeEventListener(Event.ADDED_TO_STAGE, init);
			}
	
			setupGame();
		}
	
		private function setupGame():Void
		{
			var stageWidth:Int = Lib.current.stage.stageWidth;
			var stageHeight:Int = Lib.current.stage.stageHeight;

			if (zoom == -1)
				{
					var ratioX:Float = stageWidth / gameWidth;
					var ratioY:Float = stageHeight / gameHeight;
					zoom = Math.min(ratioX, ratioY);
					gameWidth = Math.ceil(stageWidth / zoom);
					gameHeight = Math.ceil(stageHeight / zoom);
				}
			
			addChild(new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen));
	
			fpsVar = new FPS(10, 3, 0xFFFFFF);
			addChild(fpsVar);
			if(fpsVar != null) {
				fpsVar.visible = true;
			}
	
			#if html5
			FlxG.autoPause = false;
			FlxG.mouse.visible = false;
			#end
		}
}
