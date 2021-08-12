package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import flixel.group.FlxGroup;

class OutdatedSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";

	public static var page:Int = 1;
	public static var txt:FlxText;
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	var difficultySelectors:FlxGroup;
	var leftArrow:FlxSprite;
	var rightArrow:FlxSprite;

	override function create()
	{
		super.create();
		
		txt = new FlxText(0, 0, FlxG.width,
		"\n\nHi! Thanks for downloading our mod!\n\n"
		+ "\n\nPlease remember that this is a work in progress!\n\n"
		+ "\n\nThis mod adds a new miss limit system, so don't miss\n\n"
		+ "\n\ntoo much!\n\n"
		+ "\n\nYou can check your status in the lower right corner\n\n"
		+ "\n\nat all times! Good luck and see you in the full version!\n\n",
			32);
		
		txt.setFormat("VCR OSD Mono", 32, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);

		var ui_tex = Paths.getSparrowAtlas('campaign_menu_UI_assets');

		difficultySelectors = new FlxGroup();
		add(difficultySelectors);

		leftArrow = new FlxSprite(75, 150);
		leftArrow.frames = ui_tex;
		leftArrow.animation.addByPrefix('idle', "arrow left");
		leftArrow.animation.addByPrefix('press', "arrow push left");
		leftArrow.animation.play('idle');
		difficultySelectors.add(leftArrow);

		rightArrow = new FlxSprite(1200, 150);
		rightArrow.frames = ui_tex;
		rightArrow.animation.addByPrefix('idle', 'arrow right');
		rightArrow.animation.addByPrefix('press', "arrow push right", 24, false);
		rightArrow.animation.play('idle');
		difficultySelectors.add(rightArrow);
	}

	override function update(elapsed:Float)
	{
		if (controls.RIGHT)
			rightArrow.animation.play('press')
		else
			rightArrow.animation.play('idle');

		if (controls.LEFT)
			leftArrow.animation.play('press');
		else
			leftArrow.animation.play('idle');
		
		if(controls.RIGHT_P)
			{
				page++;
				if (page > 3)
					page = 3;
				if (page < 1)
					page = 1;
				switchPage();
			}

		if (controls.LEFT_P)
			{
				page--;
				if (page > 3)
					page = 3;
				if (page < 1)
					page = 1;
				switchPage();
			}

		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}

	function switchPage()
		{
			FlxG.sound.play(Paths.sound('scrollMenu'));

			switch (page)
			{
				case 1:
					txt.text =    "\n\nHi! Thanks for downloading our mod!\n\n"
								+ "\n\nPlease remember that this is a work in progress!\n\n"
								+ "\n\nThis mod adds a new miss limit system, so don't miss\n\n"
								+ "\n\ntoo much!\n\n"
								+ "\n\nYou can check your status in the lower right corner\n\n"
								+ "\n\nat all times!\n\n";
				case 2:
					txt.text =    "\n\nThe mod also includes a brand new difficulty\n\n"
								+ "\n\ncalled Bleeding Egde! You can find it after Hard!\n\n"
								+ "\n\nFaster notes, more doubles and jacks, and\n\n"
								+ "\n\nless misses until you die!\n\n"
								+ "\n\nI highly recommend you check it out, it's the most fun difficulty\n\n"
								+ "\n\nout of them all! It might also get special features in the future...\n\n";
				case 3:
					txt.text =    "\n\nFinally, check out the options menu for a perfect mode option\n\n"
								+ "\n\nand some fun stuff i sprinkled over it!\n\n"
								+ "\n\nGood luck, have fun, and don't forget to give us feedback in the\n\n"
								+ "\n\nGamebanana page! Positive or negative, it's all apreciated!\n\n"
								+ "\n\nHelp us develop the best mod possible!\n\n"
								+ "\n\nWhat did u ask? Who's Candice?\n\n";
			}
		}
}
