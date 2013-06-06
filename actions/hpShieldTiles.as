package actions {
	
	import flash.display.*;
	
	public class hpShieldTiles extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var HP_BAR:int = 1;
		public static var SHIELD_BAR:int = 2;
		public static var AMMO_BAR:int = 3;
		
		// Private Properties:
		private var type:int;
	
		// Initialization:
		public function hpShieldTiles(typeIn:int) {
			type = typeIn;
			this.gotoAndStop(type);
		}
	
		// Public Methods:

		// Protected Methods:
	}
	
}