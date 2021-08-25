package;
import flixel.*;

/**
 * ...
 * @author bbpanzu
 */
class PiracyScreen extends MusicBeatState
{
	public function new() 
	{
		super();
	}
	
	override function create() 
	{
		super.create();
		
		var screen:FlxSprite = new FlxSprite().loadGraphic(Paths.image("Bruh-Why-Did-You-Steal-Our-Mod-ps-ty-bb-for-making-this-og-code"));
		
		add(screen);
		
		
	}
	
	
	override function update(elapsed:Float) 
	{
		super.update(elapsed);
		
		if (controls.ACCEPT){
			fancyOpenURL("https://github.com/Alt-Peace/FNF-CRYSTAL-MOON");
		}
		
		
		
	}
	
}