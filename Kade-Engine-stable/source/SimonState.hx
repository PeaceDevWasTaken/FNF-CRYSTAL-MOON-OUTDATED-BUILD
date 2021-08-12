package;

import flixel.input.keyboard.FlxKey;
import haxe.Exception;
import openfl.geom.Matrix;
import openfl.display.BitmapData;
import openfl.utils.AssetType;
import lime.graphics.Image;
import flixel.graphics.FlxGraphic;
import openfl.utils.AssetManifest;
import openfl.utils.AssetLibrary;
import flixel.system.FlxAssets;

import lime.app.Application;
import lime.media.AudioContext;
import lime.media.AudioManager;
import openfl.Lib;
import Section.SwagSection;
import Song.SwagSong;
import WiggleEffect.WiggleEffectType;
import flixel.FlxBasic;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxGame;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.effects.FlxTrail;
import flixel.addons.effects.FlxTrailArea;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.addons.transition.FlxTransitionableState;
import flixel.graphics.atlas.FlxAtlas;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxBar;
import flixel.util.FlxCollision;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import flixel.util.FlxStringUtil;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;
import openfl.display.BlendMode;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

#if windows
import Discord.DiscordClient;
#end
#if windows
import Sys;
import sys.FileSystem;
#end

using StringTools;

class SimonState extends MusicBeatState
{
    public static var dad:Character;
	public static var gf:Character;
	public static var boyfriend:Boyfriend;

    public var camFollow:FlxObject;
	public static var prevCamFollow:FlxObject;
    public var camZooming:Bool = false;

    public var health:Int = 1;
    public var gfTalking:Bool = false;
    public var sequenceIndex:Int = 1;
    public var curSequence:Array<String> = [];
    public var lastSequence:String = '';
    var gfTurn:Bool = true;
    var defaultCamZoom:Float = 1.05;
    var daCode:String = "";
    var ending:Bool = false;
    public var swagCounter:Int = 0;

    override public function create()
        {
            defaultCamZoom = 0.9;
            var bg:FlxSprite = new FlxSprite(-600, -200).loadGraphic(Paths.image('stageback', 'shared'));
            bg.antialiasing = true;
            bg.scrollFactor.set(0.9, 0.9);
            bg.active = false;
            add(bg);
        
            var stageFront:FlxSprite = new FlxSprite(-650, 600).loadGraphic(Paths.image('stagefront', 'shared'));
            stageFront.setGraphicSize(Std.int(stageFront.width * 1.1));
            stageFront.updateHitbox();
            stageFront.antialiasing = true;
            stageFront.scrollFactor.set(0.9, 0.9);
            stageFront.active = false;
            add(stageFront);
        
            var stageCurtains:FlxSprite = new FlxSprite(-500, -300).loadGraphic(Paths.image('stagecurtains', 'shared'));
            stageCurtains.setGraphicSize(Std.int(stageCurtains.width * 0.9));
            stageCurtains.updateHitbox();
            stageCurtains.antialiasing = true;
            stageCurtains.scrollFactor.set(1.3, 1.3);
            stageCurtains.active = false;
            add(stageCurtains);
    
            dad = new Character(100, 100, 'simon-gf');
    
            var camPos:FlxPoint = new FlxPoint(dad.getGraphicMidpoint().x, dad.getGraphicMidpoint().y);

            dad.setPosition(400, 130);

			camPos.x += 600;

            boyfriend = new Boyfriend(770, 450, "bf");

            add(dad);
            add(boyfriend);

            camFollow = new FlxObject(0, 0, 1, 1);

            camFollow.setPosition(camPos.x, camPos.y);

            
            if (prevCamFollow != null)
                {
                    camFollow = prevCamFollow;
                    prevCamFollow = null;
                }
        
            add(camFollow);
            FlxG.camera.follow(camFollow, LOCKON, 0.04 * (30 / (cast (Lib.current.getChildAt(0), Main)).getFPS()));
            FlxG.camera.zoom = defaultCamZoom;
            FlxG.camera.focusOn(camFollow.getPosition());
            #if windows
            DiscordClient.changePresence("???", "");
            #end

            curSequence = getSequence()[0];
            trace(curSequence);
            lastSequence = buildString(getSequence()[1]);
            trace(lastSequence);

            startCountdown();
            super.create();
        }
    
    override public function update(elapsed:Float)
        {
            if(swagCounter >= 5)//wait till the invisible countdown is finished to not play animations before it loads the whole thing
                {
                    if(gfTurn)
                        {
                            if (curSequence.length >= 1 && dad.animation.curAnim.name == "idle")
                                {
                                    gfSing();
                                }
                            else if (dad.animation.finished)
                                {
                                    if (curSequence.length >= 1)
                                        dad.playAnim('idle');
                                    else
                                        {
                                            sequenceIndex += 1;
                                            curSequence = getSequence()[0];
                                            trace(curSequence);
                                            lastSequence = buildString(getSequence()[1]);  //ik it could've been easier to do this but im dumb
                                            trace(lastSequence);
                                            gfTurn = false;
                                            dad.playAnim('idle');
                                        }
                                }
                        }
                    else
                        {
                            if(FlxG.keys.justPressed.J){
                                daCode += 'u';
                                boyfriend.playAnim('singUP');
                                trace('bf sang up');
                            }
                            if(FlxG.keys.justPressed.F){
                                daCode += 'd';
                                boyfriend.playAnim('singDOWN');
                                trace('bf sang down');
                            }
                            if(FlxG.keys.justPressed.D){
                                daCode += 'l';
                                boyfriend.playAnim('singLEFT');
                                trace('bf sang left');
                            }
                            if(FlxG.keys.justPressed.K){
                                daCode += 'r';
                                boyfriend.playAnim('singRIGHT');
                                trace('bf sang right');
                            }
                            if(daCode.length == lastSequence.length)
                                {
                                    boyfriend.playAnim('idle');
                                    if (daCode != lastSequence)
                                        {
                                            health -= 1;
                                            FlxG.sound.play(Paths.music('coin', 'weekmidna'));
                                            if (health < 1){
                                                FlxG.switchState(new OutdatedSubState());
                                            }
                                        }
                                    if (buildString(curSequence) == "*")
                                        {
                                            FlxG.switchState(new MainMenuState());
                                        }
                                    else
                                        {
                                            daCode = '';
                                            gfTurn = true;
                                        }
                                }   
                        }
                }

            super.update(elapsed);
        }
    
        public function startCountdown():Void//ima delete the actual words and sounds, i only use this to wait for assets to loads fully
            {
                swagCounter = 0;
                new FlxTimer().start(Conductor.crochet / 1000, function(tmr:FlxTimer)
                {
                    dad.dance();
                    boyfriend.playAnim('idle');
        
                    var introAssets:Map<String, Array<String>> = new Map<String, Array<String>>();
                    introAssets.set('default', ['ready', "set", "go"]);
        
                    var introAlts:Array<String> = introAssets.get('default');
                    var altSuffix:String = "";
        
                    switch (swagCounter)
        
                    {
                        case 0:
                            //FlxG.sound.play(Paths.sound('intro3' + altSuffix), 0.6);
                        case 1:
                            /*var ready:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[0]));
                            ready.scrollFactor.set();
                            ready.updateHitbox();
        
                            ready.screenCenter();
                            add(ready);
                            FlxTween.tween(ready, {y: ready.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                                ease: FlxEase.cubeInOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    ready.destroy();
                                }
                            });
                            FlxG.sound.play(Paths.sound('intro2' + altSuffix), 0.6);*/
                        case 2:
                            /*var set:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[1]));
                            set.scrollFactor.set();
        
                            set.screenCenter();
                            add(set);
                            FlxTween.tween(set, {y: set.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                                ease: FlxEase.cubeInOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    set.destroy();
                                }
                            });
                            FlxG.sound.play(Paths.sound('intro1' + altSuffix), 0.6);*/
                        case 3:
                            /*var go:FlxSprite = new FlxSprite().loadGraphic(Paths.image(introAlts[2]));
                            go.scrollFactor.set();
        
                            go.updateHitbox();
        
                            go.screenCenter();
                            add(go);
                            FlxTween.tween(go, {y: go.y += 100, alpha: 0}, Conductor.crochet / 1000, {
                                ease: FlxEase.cubeInOut,
                                onComplete: function(twn:FlxTween)
                                {
                                    go.destroy();
                                }
                            });
                            FlxG.sound.play(Paths.sound('introGo' + altSuffix), 0.6);*/
                        case 4:
                    }
        
                    swagCounter += 1;
                    // generateSong('fresh');
                }, 5);
            }
        public function getSequence():Array<Array<String>>
            {
                var sq:Array<Array<String>> = [];
                sq[0] = CoolUtil.coolTextFile(Paths.txt('simonsays'))[sequenceIndex].split('');
                sq[1] = CoolUtil.coolTextFile(Paths.txt('simonsays'))[sequenceIndex - 1].split('');
                return sq;
            }

        public function buildString(array:Array<String>):String
            {
                var string:String = '';
                var i:Int = 0;
                while (i < array.length)
                    {
                        string += array[i];
                        i += 1;
                    }
                return string;
            }
        function gfSing() {
            switch(curSequence[0])
            {
                case "u":
                    dad.playAnim('singUP');
                    trace('gf sang up');
                case "d":
                    dad.playAnim('singDOWN');
                    trace('gf sang down');
                case "l":
                    dad.playAnim('singLEFT');
                    trace('gf sang left');
                case "r":
                    dad.playAnim('singRIGHT');
                    trace('gf sang right');
            }
            curSequence.remove(curSequence[0]);
        }
}