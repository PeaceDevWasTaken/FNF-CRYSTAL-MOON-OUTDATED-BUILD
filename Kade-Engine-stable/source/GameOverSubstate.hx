package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSubState;
import flixel.math.FlxPoint;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxEase;

class GameOverSubstate extends MusicBeatSubstate
{
	var bf:Boyfriend;
	var camFollow:FlxObject;

	var stageSuffix:String = "";
	public static var sex:String = "";

	public function new(x:Float, y:Float)
	{
		var daStage = PlayState.curStage;
		var daBf:String = '';
		switch (PlayState.SONG.player1)
		{
			case 'bf-pixel':
				stageSuffix = '-pixel';
				daBf = 'bf-pixel-dead';
			default:
				daBf = 'bf';
		}

		if (PlayState.SONG.song.toLowerCase() == 'balls')
		{
			sex = '-funni';
		}

		super();

		Conductor.songPosition = 0;

		bf = new Boyfriend(x, y, daBf);
		add(bf);

		camFollow = new FlxObject(bf.getGraphicMidpoint().x, bf.getGraphicMidpoint().y, 1, 1);
		add(camFollow);
		
		FlxG.sound.play(Paths.sound('fnf_loss_sfx' + stageSuffix + sex));

		Conductor.changeBPM(100);

		// FlxG.camera.followLerp = 1;
		// FlxG.camera.focusOn(FlxPoint.get(FlxG.width / 2, FlxG.height / 2));
		FlxG.camera.scroll.set();
		FlxG.camera.target = null;

		bf.playAnim('firstDeath');
		if (FlxG.random.bool(10))
		{
			//			FlxG.sound.play(Paths.music('coin', 'weekmidna')); testing stuff lmao
		}
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.ACCEPT)
		{
			endBullshit();
		}

		if (controls.BACK)
		{
			FlxG.sound.music.stop();

			if (PlayState.isStoryMode)
				FlxG.switchState(new StoryMenuState());
			else
				FlxG.switchState(new FreeplayState());
			PlayState.loadRep = false;
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.curFrame == 12)
		{
			FlxG.camera.follow(camFollow, LOCKON, 0.01);
		}

		if (bf.animation.curAnim.name == 'firstDeath' && bf.animation.curAnim.finished)
		{
			FlxG.sound.playMusic(Paths.music('gameOver' + stageSuffix));
			if (PlayState.curStage == 'midna')
			{
				FlxG.sound.music.volume = 0.2;
					if (FlxG.random.bool(10))
						{
							FlxG.sound.play(Paths.soundRandom('midnalines/bfdead/', 15, 16), function volume():Void
								{
									FlxTween.tween(FlxG.sound.music, {volume: 1}, 1, {ease: FlxEase.cubeInOut});
								});
						}
					else
						{FlxG.sound.play(Paths.soundRandom('midnalines/bfdead/', 1, 14), function volume():Void
						{
							FlxTween.tween(FlxG.sound.music, {volume: 1}, 1, {ease: FlxEase.cubeInOut});
						});}
				
			}
		}

		if (FlxG.sound.music.playing)
		{
			Conductor.songPosition = FlxG.sound.music.time;
		}
	}

	override function beatHit()
	{
		super.beatHit();

		FlxG.log.add('beat');
	}

	var isEnding:Bool = false;

	function endBullshit():Void
	{
		if (!isEnding)
		{
			isEnding = true;
			bf.playAnim('deathConfirm', true);
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.music('gameOverEnd' + stageSuffix + sex));
			new FlxTimer().start(0.7, function(tmr:FlxTimer)
			{
				FlxG.camera.fade(FlxColor.BLACK, 2, false, function()
				{
					if (PlayState.SONG.song.toLowerCase() == 'balls')
					{
						PlayState.storyDifficulty = 1;

						PlayState.SONG = Song.loadFromJson("balls", "balls");
						PlayState.campaignScore = 0;
						LoadingState.loadAndSwitchState(new PlayState(), true);
					}
					else
					{
						LoadingState.loadAndSwitchState(new PlayState());
					}
				});
			});
		}
	}
}
