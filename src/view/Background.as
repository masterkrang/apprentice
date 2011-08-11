package view
{
	import flash.display.Sprite;
	
	public class Background extends Sprite
	{
		
		public var bg:Sprite;
		
		public function Background(w:uint, h:uint, x:uint, y:uint)
		{
			super();
			createBG(w,h,x,y);
		}
		
		public function createBG(w:uint, h:uint, x:uint, y:uint):void {
			bg = new Sprite();
			bg.graphics.beginFill(0xFF0000, .4);
			bg.graphics.drawRect(w,h,x,y);//parent.stage.width, parent.stage.height);
			bg.graphics.endFill();
			addChild(bg);
		}
	}
}