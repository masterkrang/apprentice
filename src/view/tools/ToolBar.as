package view.tools
{
	
	import flash.display.Sprite;
	
	public class ToolBar extends Sprite
	{
		
		private var bg:Sprite = new Sprite();
		private var tools:Vector.<Tool>;
		
		public function ToolBar(w:Number, h:Number)
		{
			init();
			draw(w,h);	
		}
		
		private function init():void {
			
		}
		
		private function reloadTools():void {
			//if new tools or added or deleted
		}
		
		public function drawMyself() {
			//get the parent's width and height (probably stage)
			
		}
		
		
		/* this should draw a cool mac-like panel and throw it on the bottom
		 * this will eventually hold all of the tools which should probably com
		 * from an xml file depending on what the user chooses
		 */
		public drawPanel():void {
			//this.toolBar.graphics
			this.
		}
		
	}
}