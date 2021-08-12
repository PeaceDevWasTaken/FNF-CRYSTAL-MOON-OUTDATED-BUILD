package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class SecretState extends MusicBeatState
{
    public var bg:FlxSprite;
    public var first:FlxSprite;
    public var second:FlxSprite;
    public var third:FlxSprite;
    public var forth:FlxSprite;
    public var fifth:FlxSprite;
    public var sixth:FlxSprite;
    public var seventh:FlxSprite;
    public var eight:FlxSprite;
    public var nineth:FlxSprite;
    public var tenth:FlxSprite;
    public var eleventh:FlxSprite;
    public var twelveth:FlxSprite;
    public var thirdteenth:FlxSprite;

    override function create()
        {
            super.create();
            bg = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.WHITE);
            bg.screenCenter();
            add(bg);

            first = new FlxSprite().makeGraphic(300, 300);
            first.screenCenter();
            first.color = 0xFFFFB266;
            add(first);

            second = new FlxSprite().makeGraphic(50, 300, FlxColor.BLACK);
            second.x = first.x;
            second.y = first.y;
            add(second);

            third = new FlxSprite().makeGraphic(25, 300);
            third.x = first.x + second.width;
            third.y = first.y;
            third.color = 0xFFCC0000;
            add(third);

            forth = new FlxSprite().makeGraphic(25, 180);
            forth.x = third.x + third.width;
            forth.y = first.y;
            forth.color = 0xFF663300;
            add(forth);
            
            fifth = new FlxSprite().makeGraphic(25, 120);
            fifth.x = forth.x;
            fifth.y = first.y + forth.height;
            fifth.color = 0xFFD19939;
            add(fifth);

            sixth = new FlxSprite().makeGraphic(25, 100);
            sixth.x = forth.x + forth.width;
            sixth.y = first.y;
            sixth.color = forth.color;
            add(sixth);

            seventh = new FlxSprite().makeGraphic(225, 100);
            seventh.x = sixth.x + sixth.width;
            seventh.y = first.y;
            seventh.color = 0xFF994C00;
            add(seventh);

            eight = new FlxSprite().makeGraphic(200, 80);
            eight.x = forth.x + forth.width;
            eight.y = first.y + seventh.height;
            eight.color = fifth.color;
            add(eight);

            nineth = new FlxSprite().makeGraphic(25, 50);
            nineth.x = forth.x + forth.width;
            nineth.y = eight.y + 50;
            nineth.color = FlxColor.WHITE;
            add(nineth);

            tenth = new FlxSprite().makeGraphic(25, 50);
            tenth.x = nineth.x + nineth.width;
            tenth.y = nineth.y;
            tenth.color = 0xFF000099;
            add(tenth);

            eleventh = new FlxSprite().makeGraphic(50, 25);
            eleventh.x = tenth.x + tenth.width + 25;
            eleventh.y = tenth.y + tenth.height;
            eleventh.color = eight.color;
            add(eleventh);

            twelveth = new FlxSprite().makeGraphic(25, 50, nineth.color);
            twelveth.x = eleventh.x + eleventh.width + 25;
            twelveth.y = nineth.y;
            add(twelveth);

            thirdteenth = new FlxSprite().makeGraphic(25, 50, tenth.color);
            thirdteenth.x = twelveth.x + twelveth.width;
            thirdteenth.y = tenth.y;
            add(thirdteenth);
        }
    
    override function update(elapsed)
        {
            super.update(elapsed);
        }
}