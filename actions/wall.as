package actions {
	
	import flash.display.*;
	import flash.events.*;
	
	public class wall extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var LEFT_WALL:int = 1;
		public static var RIGHT_WALL:int = 2;
		
		// Private Properties:
		private var player:ship;
		private var type:int;
	
		// Initialization:
		public function wall() {
		}
	
		// Public Methods:
		public function setPlayer(player:ship):void {
			this.player = player;
		}
		
		public function setWall(wallIn:int):void {
			type = wallIn;
			this.gotoAndStop(wallIn);
		}
		// Protected Methods:
	}
	
}