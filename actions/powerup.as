package actions {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	
	public class powerup extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var EXAMPLE:int = 0;
		public static var WPN1:int = 1;
		public static var WPN2:int = 2;
		public static var HPUP:int = 3;
		public static var SPUP:int = 4;
		public static var HEALTH:int = 5;
		public static var SHIELD:int = 6;
		
		public static var POINTS:int = 0;
		public static var NOTHING:int = 1;
		
		//[RECHARGE,DAMAGE,SPEED,CHANNEL]
		public static var EXAMPLEa:Array = new Array(POINTS,NOTHING);
		public static var WPN1a:Array = new Array(1,0);
		public static var WPN2a:Array = new Array(1,0);
		public static var HPUPa:Array = new Array(10,0);
		public static var HEALTHa:Array = new Array(25,0);
		public static var SPUPa:Array = new Array(10,0);
		public static var SHIELDa:Array = new Array(25,0);
		
		public static var powerups:Array = new Array(EXAMPLEa,WPN1a,WPN2a,HPUPa,HEALTHa,SPUPa,SHIELDa);

		// Private Properties:
		private var spawner:MovieClip;
		private static var player:ship;
		private var aStage:Stage;

		private var type:int;
		
		private static var tracker:Array = new Array();
		private static var count:int = 0;
		public var id:int;
		
		// Initialization:
		public function powerup(spawner:MovieClip,stageIn:Stage) {
			aStage = stageIn;
			this.spawner = spawner;
			setType();
			
			this.x = spawner.x;
			this.y = spawner.y
			
			aStage.addEventListener(Event.ENTER_FRAME, eventHandler,false,0,true);
			addTracker();
		}
	
		// Public Methods:
		public function setType():void {
			type = (int) (Math.random()*4)+1;
			this.gotoAndStop(type);
		}
		
		private var rotDir:int = (int) (Math.random()*2)+1;

		// Protected Methods:
		private function eventHandler(event:Event):void {
			if(rotDir == 1) {
				if(this.rotation >= 359)
					this.rotation = 0;
				else
					this.rotation += 1;
			}
			if(rotDir == 2) {
				if(this.rotation <= -359) {
					this.rotation = 0;
				}
				else {
					this.rotation -= 1;
				}
			}
			
			if(this.hitTestObject(player)) {
				player.skillUp(type);
				this.remove();
			}
			
		}
		
		public static function spawn(spawnerIn:MovieClip,aStage:Stage):void {
			if(spawnerIn.y > 0 && spawnerIn.y < 600) {
				if((int)(Math.random()*3) == (int)(Math.random()*3))
					new powerup(spawnerIn,aStage);
			}
		}
		
		public static function setPlayer(pIn:ship):void {
			player = pIn;
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

			trace("PowUp("+id+"): spawned, type " + type);
			
			aStage.addChild(this);
		}
		
		public function remove() {
			if(tracker[id] != null) {
				aStage.removeEventListener(Event.ENTER_FRAME, eventHandler);
				aStage.removeChild(this);
				tracker[id] = null;

				trace("PowUp("+id+"): removed");
			}
		}
		
		public static function getPowerups():Array {
			return tracker;
		}
		
		public function explode():void {
			new explosion(this,explosion.BIG,aStage);
			remove();
		}
		
		public static function gameOver():void {
			for(var i:int = 0; i < tracker.length; i++) {
				if(tracker[i] != null)
					tracker[i].remove();
			}
		}
		
	}
}