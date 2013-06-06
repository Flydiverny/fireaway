package actions {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class stats extends MovieClip {
		
		// Constants:
		// Public Properties:
		private var score:int;
		private var fC:int = 0;
		private var out:TextField = new TextField();
		private var format:TextFormat = new TextFormat();
		private var spawner:MovieClip;
		
		// Private Properties:
		private static var totScore:int;
		private static var projectilesFired:int;
		private static var enemiesKilled:int;
		
		private static var stats_mc:MovieClip;
		private static var totScoreText:TextField;
		
		private static var aStage:Stage;
		private static var player:MovieClip;

		private static var tracker:Array = new Array();
		private static var count:int = 0;
		public var id:int;
	
		// Initialization:
		public function stats(spawner:MovieClip,scoreIn:int) {
			this.spawner = spawner;
			addScore(scoreIn);
			setText(scoreIn);
			
			score = scoreIn;
			
			this.x = spawner.x+10;
			this.y = spawner.y-10;
			
			aStage.addEventListener(Event.ENTER_FRAME,eventHandler);
			
			addTracker();
		}
	
		// Public Methods:
		private function eventHandler(event:Event):void {
			this.alpha -= 0.03;
			
			if(fC < 10)
				format.size = 12+fC;
			else
				format.size = 32-fC;

			out.defaultTextFormat = format;
			out.text = out.text;
			
			fC++;
			
			if(fC == 23)
				this.remove();
		}
		
		// Protected Methods:
		private function setText(txtIn:int):void {
			out.autoSize = TextFieldAutoSize.CENTER;
            
            format.font = "Verdana";
            format.color = 0x66CD00;
            format.size = 10;
			out.defaultTextFormat = format;
			
			out.text = "+"+txtIn;
			out.textColor = 0x66CD00;
			
			if(spawner == player) {
				var output:String = "-"+(txtIn*-1);
				out.text = output;
				format.color = 0xFF0000;
				out.textColor = 0xFF0000;
			}
			
			
			
			out.visible = true;
			this.addChild(out);
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

			trace("Stats("+id+"): spawned, score " + score);
			
			aStage.addChild(this);
		}
		
		public static function projFired():void {
			projectilesFired += 1;
		}
		
		public static function enemyKilled():void {
			enemiesKilled += 1;
		}
		
		public static function getProjFired():int {
			var returnVar = projectilesFired;
			projectilesFired = 0;
			return returnVar;
		}
		
		public static function getTotalScore():int {
			var returnVar = totScore;
			totScore = 0;
			return returnVar;
		}
		
		public static function getEnemiesKilled():int {
			var returnVar = enemiesKilled;
			enemiesKilled = 0;
			return returnVar;
		}
		
		public function remove() {
			if(tracker[id] != null) {
				aStage.removeEventListener(Event.ENTER_FRAME, eventHandler);
				aStage.removeChild(this);
				tracker[id] = null;

				trace("Stats("+id+"): removed");
			}
		}
		
		private function addScore(scoreIn:int):void {
			totScore += scoreIn;
			var output:String = "" + totScore;
			totScoreText.text = output;
		}
		
		public static function setStatsMC(statsMcIn:MovieClip,stgIn:Stage,pIn:MovieClip):void {
			stats_mc = statsMcIn;
			aStage = stgIn;
			totScoreText = stats_mc.scoreTxt;
			player = pIn;
		}
		
		public static function gameOver():void {
			for(var i:int = 0; i < tracker.length; i++) {
				if(tracker[i] != null)
					tracker[i].remove();
			}
		}
		
	} //End Class
}