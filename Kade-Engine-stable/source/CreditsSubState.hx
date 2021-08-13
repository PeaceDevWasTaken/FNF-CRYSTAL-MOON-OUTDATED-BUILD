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

class CreditsSubState extends MusicBeatState
{
	public static var leftState:Bool = false;

	public static var needVer:String = "IDFK LOL";
	public static var currChanges:String = "dk";
	
	private var bgColors:Array<String> = [
		'#314d7f',
		'#4e7093',
		'#70526e',
		'#594465'
	];
	private var colorRotation:Int = 1;

	override function create()
	{
		super.create();
		
		var txt:FlxText = new FlxText(0, 0, FlxG.width,
			"\n\nCREDITS:\n\n"
			+ "\n\nLead: Alternate Peace\n\n"
			+ "\n\nCoding: CarlDev & Alternate Peace\n\n"
			+ "\n\nMusic: Ghasty\n\n"
			+ "\n\nArt and Animation: Meliach, Kitty, Haram!64\n\n"
			+ "\n\nVoice Acting: CaitlinDiVA\n\n"
			+ "\n\nChart: Kalpy\n\n"
			+ "\n\nEXTRA CREDITS:\n\n"
			+ "\n\nNinjamuffin99, PhantomArcade, Kawaisprite, Evilsk8er\n\n"
			+ "\n\nKadeDev\n\n"
			+ "\n\nSPECIAL THANKS to Brightfyre and HayseedHere as well as slameron for helping with coding issues!\n\n",
			18);
		
		txt.setFormat("VCR OSD Mono", 18, FlxColor.fromRGB(200, 200, 200), CENTER);
		txt.borderColor = FlxColor.BLACK;
		txt.borderSize = 3;
		txt.borderStyle = FlxTextBorderStyle.OUTLINE;
		txt.screenCenter();
		add(txt);
	}

	override function update(elapsed:Float)
	{
		if (controls.ACCEPT)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		if (controls.BACK)
		{
			leftState = true;
			FlxG.switchState(new MainMenuState());
		}
		super.update(elapsed);
	}
}
