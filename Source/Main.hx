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
	var gameWidth:Int = 1368;
	var gameHeight:Int = 700;
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
			addChild(new FlxGame(gameWidth, gameHeight, initialState, Std.int(framerate), Std.int(framerate), false, startFullscreen));
	
			var ourSource:String = "Assets/FunnyVideos/DO NOT DELETE OR GAME WILL CRASH/dontDelete.webm";

			#if web
			var str1:String = "HTML CRAP";
			var vHandler = new VideoHandler();
			vHandler.init1();
			vHandler.video.name = str1;
			addChild(vHandler.video);
			vHandler.init2();
			GlobalVideo.setVid(vHandler);
			vHandler.source(ourSource);
			#elseif desktop
			var str1:String = "WEBM SHIT"; 
			var webmHandle = new WebmHandler();
			webmHandle.source(ourSource);
			webmHandle.makePlayer();
			webmHandle.webm.name = str1;
			addChild(webmHandle.webm);
			GlobalVideo.setWebm(webmHandle);
			#end
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
