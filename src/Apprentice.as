package
{
	import com.greensock.TweenLite;
	
	import flash.desktop.NativeApplication;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.events.KeyboardEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	import flash.system.Capabilities;
	import flash.utils.Timer;
	import view.Background;
	import view.Comp;
	import view.tools.Console;
	
	public class Apprentice extends Sprite
	{
		//timer
		public var timer:Timer = new Timer(5000);
		
		//default opacity for comp overlay
		public var defaultOpacity:Number = .6;
		//window
		public var win:NativeWindow;
		
		public var nativeWinOptions:NativeWindowInitOptions;
	
		//loader for loading images from local file system
		public var imageLoader:Loader;
		
		public var comp:Comp; //this should be a class comp
		public var comps:Vector.<Comp>;
		
		public var bg:Background;
		
		//file
		public var fileToOpen:File = new File();
		public var txtFilter:FileFilter = new FileFilter("Images", "*.jpg;*.gif;*.png;*.jpeg;");
		
		//for debugging
		public var console:Console = new Console();
		
		public function Apprentice()
		{
			
			timer.addEventListener(TimerEvent.TIMER, ding);
			//timer.start();
			comp = new Comp();
			comp.alpha = defaultOpacity;
			//createWindow();
			//transparentWindow();
			createTransparentWindow();
			//align stage
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			openFile();
			createBackground();
			//addChild(bg);
			//win.stage.addChild(bg);
			
			console.x = 900;
			console.y = 0;
			console.visible = true;
			//addChild(comp);
			//addChild(console);
			
			//setNudgingListeners();
			setListeners();
			
			initToolBar();
		}
		
		/* this function could contain a list of listener functions that need to be set
		on apprentice initialization. for each function a short description, and within each of those
		function definitions an even longer description ;) */
		
		public function setListeners():void {
			
			//set listeners on arrow presses for moving the comp pixel by pixel
			setNudgingListeners();
			
			//set 
			
		
		}
		/*
		public setGlobalMouseListeners():void {
		
		}
		*/
		
		public function setOpacity(opacity:Number):void {
			comp.alpha = opacity;
		}
		
		public function initToolBar():void {
			//loads current tools and ass images, check for updates
		}
		
		//listens for arrow movements to nudge the app
		public function setNudgingListeners():void {
			
			addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
		
		public function keyDown(ke:KeyboardEvent):void {
			console.echo("charcode: " + ke.charCode.toString());
			console.echo("keycode: " + ke.keyCode.toString());
			//61 = -  to brighten
			//45 = +  to dim
			
			//dim
			if(ke.charCode == 45) {
				dimComp();
			}
			
			if(ke.charCode == 61) {
				brightenComp();
			}
			//down arrow = 40
			//up arrow = 38
			//right arrow = 39
			//left arrow = 37
			
			//down arrow
			
			
			//shift key for big boy movements
			
			if(ke.shiftKey == true) {
				if(ke.keyCode == 40) {
					comp.y = comp.y + 5;
				}
				
				//up arrow
				if(ke.keyCode == 38) {
					comp.y = comp.y - 5;
				}
				
				if(ke.keyCode == 39) {
					comp.x = comp.x + 5;
				}
				
				if(ke.keyCode == 37) {
					comp.x = comp.x - 5;
				}
			} else {
				//little boy movements
				if(ke.keyCode == 40) {
					comp.y = comp.y + 1;
				}
				
				//up arrow
				if(ke.keyCode == 38) {
					comp.y = comp.y - 1;
				}
				
				if(ke.keyCode == 39) {
					comp.x = comp.x + 1;
				}
				
				if(ke.keyCode == 37) {
					comp.x = comp.x - 1;
				}
			}
		}
		
		public function brightenComp():void {
			if(comp.alpha < 1){
				comp.alpha += .1;
			}
		}
		
		public function dimComp(): void {
			if(comp.alpha > 0) {
				comp.alpha -= .1;
			}
		}
		
		public function setInitialAppSize():void {
			//nativeWindow.x = (Capabilities.screenResolutionX - nativeWindow.width) / 2;
			//nativeWindow.y = (Capabilities.screenResolutionY - nativeWindow.height) / 2;

		}
		
		public function ding(te:TimerEvent):void { closeApp();}
		
		public function closeApp():void {
			stage.nativeWindow.close();
		}
		
		public function createBackground():void {
			bg = new Background(Capabilities.screenResolutionX, Capabilities.screenResolutionY,0,0);
			bg.buttonMode = true;
			//bg.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			addChild(bg);
		}
		
		public function onBackgroundMouseDown(me:MouseEvent):void {
			stage.nativeWindow.startMove();
		}
		
		public function openFile():void {
			console.echo("open file");
			try 
			{
				fileToOpen.browseForOpen("Open", [txtFilter]);
				fileToOpen.addEventListener(Event.SELECT, fileSelected);
			}
			catch (error:Error)
			{
				console.echo("Failed:");//, error.message);
			}
				
		}
		
		public function fileSelected(event:Event):void 
		{
			
			//probably should send the file to the comp and let the comp open it and load it
			
			//fileToOpen.load();
			console.echo("file selected" + fileToOpen.url);
			
			//load image
			imageLoader = new Loader();
			//imageLoader.con
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadComplete);	
			
			try {
				imageLoader.load(new URLRequest(fileToOpen.url));
			} catch (e:Error) {console.echo("error" + e.message)}
			//comp.addChild();
			//win.stage.stage.addChild(comp);
			//var stream:FileStream = new FileStream();
			//stream.open(event.target, FileMode.READ);
			//var fileData:String = stream.readUTFBytes(stream.bytesAvailable);
			//trace(fileData);
		}
		
		public function imageLoadComplete(e:Event):void {
			console.echo("\nimageload complete" + e.target);
			
			//add image to comp
			//comp.addChild(e.target.loader);
			//add comp to a window
			//win.stage.addChild(comp);
			
			var bmp:Bitmap = new Bitmap();
			//bmp = loader.content as Bitmap;
			console.echo("\n" + e.target.content);
			bmp = e.target.content as Bitmap;
			comp.addChild(bmp);
			
			//may want to rethink whether comp should have listeners here or at all
			
			//comp listeners
			comp.addEventListener(MouseEvent.MOUSE_DOWN, compMouseDown);
			comp.addEventListener(MouseEvent.MOUSE_OVER, compMouseOver);
			comp.addEventListener(MouseEvent.MOUSE_OUT, compMouseOut);
			
			//comp settings
			comp.buttonMode = true;
			comp.useHandCursor = true;
			//comp.mouseChildren = false;
			//comp.mouseEnabled = true;
			
			
			addChild(comp);
			addChild(console);
			
			//add to window
			win.stage.addChild(comp);
		}
		
		
		/* COMP LISTENERS *******************************************/
		
		public function compMouseDown(me:MouseEvent):void {
			stage.nativeWindow.startMove();
		}
		
		public function compMouseOut(me:MouseEvent):void {
			console.echo("compMouseOut");
		}
		
		public function compMouseOver(me:MouseEvent):void {
			console.echo("compMouseOver");
			comp.alpha = 1;
			TweenLite.to(comp, 1, {alpha:defaultOpacity});
		}
		
		/*************************************************************/
		
		//used for creating as3 project in air
		public function createWindow():void {
			win =
				new NativeWindow(new NativeWindowInitOptions());
			win.activate();
			win.addEventListener(Event.CLOSE, function():void {
				NativeApplication.nativeApplication.exit(0);
			});
			
			win.stage.addChild(this);
		}
		
		public function createTransparentWindow():void {
			
			
			nativeWinOptions = new NativeWindowInitOptions();
			nativeWinOptions.transparent = true;
			nativeWinOptions.systemChrome = "none";
			
			win =
				new NativeWindow(nativeWinOptions);
			
			win.x = 0; //(Capabilities.screenResolutionX - nativeWindow.width) / 2;
			win.y = 0; // (Capabilities.screenResolutionY - nativeWindow.height) / 2;
			win.width = Capabilities.screenResolutionX;
			win.height = Capabilities.screenResolutionY;
			win.title = "apprentice";
			
			
			win.activate();
			win.addEventListener(Event.CLOSE, function():void {
				NativeApplication.nativeApplication.exit(0);
			});
			
			win.stage.addChild(this);
		}
	}
}