package actions {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	
	public class explosion extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var EXAMPLE:int = 0;
		public static var BIG:int = 1;
		public static var SMALL:int = 2;
		
		public static var FRAMES:int = 0;
		public static var NOTHING:int = 1;
		
		//[RECHARGE,DAMAGE,SPEED,CHANNEL]
		public static var EXAMPLE_SPECCS:Array = new Array(FRAMES,NOTHING);
		public static var BIG_SPECCS:Array = new Array(22,0);
		public static var SMALL_SPECCS:Array = new Array(22,0);
		public static var explosions:Array = new Array(EXAMPLE_SPECCS,BIG_SPECCS,SMALL_SPECCS);

		// Private Properties:
		private var spawner:MovieClip;
		private static var player:ship;
		private var aStage:Stage;

		private var type:int;
		private var frameCounter:int;
		
		private static var tracker:Array = new Array();
		private static var count:int = 0;
		public var id:int;
		
		// Initialization:
		public function explosion(spawner:MovieClip,typeIn:int,stageIn:Stage) {
			aStage = stageIn;
			this.spawner = spawner;
			setType(typeIn);
			
			this.x = spawner.x;
			this.y = spawner.y
			
			aStage.addEventListener(Event.ENTER_FRAME, eventHandler,false,0,true);
				
			addTracker();
		}
	
		// Public Methods:
		public function setType(typeIn:int):void {
			type = typeIn;
			this.gotoAndStop(type);
		}

		// Protected Methods:
		private function eventHandler(event:Event):void {
			if(frameCounter == explosions[type][FRAMES])
				this.remove();
			else
				frameCounter++;
		}
		
		private function addTracker():void {
			count = tracker.length;
				
			for(var i:int = 0; i < tracker.length; i++) {
				if(tracker[i] == null) {
					id = i;
					break;	//FOUND STOP LOOPING
				}
			}
			
			while(tracker[id] != null) {
				id = count;
				count++;
			}

			tracker[id] = this;

			trace("Explo("+id+"): spawned");
			
			aStage.addChild(this);
		}
		
		public function remove() {
			if(tracker[id] != null) {
				aStage.removeEventListener(Event.ENTER_FRAME, eventHandler);
				aStage.removeChild(this);
				tracker[id] = null;

				trace("Explo("+id+"): removed");
			}
		}
		
		public static function gameOver():void {
			for(var i:int = 0; i < tracker.length; i++) {
				if(tracker[i] != null)
					tracker[i].remove();
			}
		}
		
	}
}