package view.tools
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class Console extends Sprite
	{
		public var defaultText:String = "hi console";
		public var console:TextField;
		public var useConsoleDebugging:Boolean = true;
		
		public function Console()
		{
			super();
			createConsole();
		}
		
		public function createConsole():void {
			console = new TextField();
			
			console.type = TextFieldType.DYNAMIC;
			console.wordWrap = true;
			
			console.background = true;
			console.backgroundColor = 0xFFFFFF;
			
			console.border = true;
			
			console.height = 800;
			console.width = 800;
			
			console.x = 100;
			
			console.y = 100;
			
			console.text = this.defaultText;
			
			if(this.useConsoleDebugging) {
				this.addChild(console);
			}
			
		}
		
		public function echo(str:String): void {
			this.console.appendText("\n" + str);
		}
		
		public function getText():String {
			return this.console.text;
		}
	}
}