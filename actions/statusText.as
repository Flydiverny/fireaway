package actions {
	
	import flash.display.*;
	import flash.events.*;
	
	public class statusText extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var HEALTH:int = 1;
		public static var SHIELD:int = 2;
		public static var BOSS:int = 3;
		
		// Private Properties:
		private var type:int;
		private var aStage:Stage;
		private var fC:int = 0;
		private var tfC:int = 0;
		private static var FA:MovieClip;
		private static var showing:Boolean = false;
		private static var tracker:statusText;
	
		// Initialization:
		public function statusText(typeIn:int, stgIn:Stage) {
			if(!showing) {
				tracker = this;
				type = typeIn;
				aStage = stgIn;
				
				this.x = 0;
				this.y = 275;
				this.gotoAndStop(type);
				aStage.addEventListener(Event.ENTER_FRAME,showHide);
				aStage.addChild(this);
				showing = true;
			}
			else {
				tracker.remove();
				new statusText(typeIn, stgIn);
			}
		}
	
		// Public Methods:
		private function showHide(event:Event):void {
			var frames:int = 8;
			tfC++;
			if(this.visible && fC == frames)
				this.visible = false;
			else if(!this.visible && fC == frames)
				this.visible = true;
			
			if(fC == frames)
				fC = 0;
			
			fC++;
			
			if(tfC == frames*5) {
				aStage.removeChild(this);
				aStage.removeEventListener(Event.ENTER_FRAME,showHide);
				showing = false;
				if(type == 6)
					FA.gameOver();
			}
		}
		
		private function remove() {
			aStage.removeChild(this);
			aStage.removeEventListener(Event.ENTER_FRAME,showHide);
			showing = false;
		}
		// Protected Methods:
		public static function setFA(FAIN:MovieClip):void {
			FA = FAIN;
		}
	}
	
}