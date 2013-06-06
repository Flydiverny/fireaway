package actions {
	
	import flash.display.*;
	import flash.events.*;
	import flash.ui.Keyboard;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	
	public class fireAway extends MovieClip {
		
		// Constants:
		// Public Properties:
		// Private Properties:
		private var frameCount:int = 0;
		
		private var startIntro:Boolean = true;
		private var startMenu:Boolean;
		private var startStory:Boolean;
		private var startCredits:Boolean;
		private var startGame:Boolean;
		private var startControls:Boolean;
		private var startGameOver:Boolean;
		
		private var version:String = "Beta 1.3";

		// Initialization:
		public function fireAway() {
			stage.addEventListener(Event.ENTER_FRAME,sceneHandler);
		}
		
		private function sceneHandler(event:Event):void {
			frameCount++;
			if(startIntro)
				introInit();
			
			if(startMenu)
				menuInit();
			
			if(startStory)
				storyInit();
			
			if(startCredits)
				creditsInit();
			
			if(startControls)
				controlsInit();
			
			if(startGame)
				GameInit();
			
			if(startGameOver)
				gameOverInit();
		}

		// Public Methods:
		
		// Controls Methods
		public function gameOver():void {
			projectile.gameOver();
			enemies.gameOver();
			powerup.gameOver();
			stats.gameOver();
			explosion.gameOver();
			hpBar.removeValueTxt();
			ammoBar.removeValueTxt();
			shieldBar.removeValueTxt();
			spawnCounter = 0;
			msgCount = 0;
			
			stage.removeEventListener(Event.ENTER_FRAME,addEnemy);
			startGameOver = true;
		}
		
		private function gameOverInit():void {
			trace("Game(ST): GameOver/Score started.");
			startGameOver = false;
			
			var score:int = stats.getTotalScore();
			var proj:int = stats.getProjFired();
			var ek:int = stats.getEnemiesKilled();
			
			gotoAndStop(1,"GameOver");
			
			endEkTxt.text = ""+ek;
			endProjTxt.text = ""+proj;
			endScoreTxt.text = ""+score;
			
			newGame_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			credits_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			controls_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			imlol_btn.addEventListener(MouseEvent.CLICK,menuHandler);
		}
		
		private function controlsInit():void {
			trace("Game(ST): Controls started.");
			gotoAndStop(1,"Controls");
			startControls = false;
			
			newGame_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			credits_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			menu_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			imlol_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			//controls_btn.addEventListener(MouseEvent.CLICK,menuHandler);
		}
		
		// Credits Methods:
		private function creditsInit():void {
			trace("Game(ST): Credits started.");
			gotoAndStop(1,"Credits");
			startCredits = false;
			
			newGame_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			//credits_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			menu_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			imlol_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			controls_btn.addEventListener(MouseEvent.CLICK,menuHandler);
		}
		
		// Menu Methods:
		private function menuInit():void {
			trace("Game(ST): Menu started.");
			gotoAndStop(1,"Menu");
			startMenu = false;
			
			newGame_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			credits_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			//menu_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			imlol_btn.addEventListener(MouseEvent.CLICK,menuHandler);
			controls_btn.addEventListener(MouseEvent.CLICK,menuHandler);
		}
		
		private function menuHandler(event:MouseEvent):void {
			var removeListeners:Boolean = true;
			switch(event.currentTarget.name) {
				case "newGame_btn":
					startStory = true;
					break;
				case "credits_btn":
					startCredits = true;
					break;
				case "controls_btn":
					startControls = true;
					break;
				case "menu_btn":
					startMenu = true;
					break;
				case "imlol_btn":
					var targetURL:URLRequest = new URLRequest("http://www.imlol.eu/");
					navigateToURL(targetURL);
					removeListeners = false;
					break;
			}
			
			if(removeListeners) {
				if(newGame_btn != null)
					newGame_btn.removeEventListener(MouseEvent.CLICK,menuHandler);
				if(credits_btn != null)
					credits_btn.removeEventListener(MouseEvent.CLICK,menuHandler);
				if(controls_btn != null)
					controls_btn.removeEventListener(MouseEvent.CLICK,menuHandler);
				if(imlol_btn != null)
					imlol_btn.removeEventListener(MouseEvent.CLICK,menuHandler);
				if(menu_btn != null)
					menu_btn.removeEventListener(MouseEvent.CLICK,menuHandler);
			}
		}
		
		// Intro Methods:
		private function introInit():void {
			trace("Game(ST): Intro started.");
			gotoAndStop(1,"Intro");
			startIntro = false;
			versionTxt.text = version;
			play_mc.visible = false;
			stage.addEventListener(Event.ENTER_FRAME,introHandler);
			copy_mc.addEventListener(MouseEvent.CLICK,copyClick);
		}
		
		private function copyClick(event:MouseEvent):void {
			var targetURL:URLRequest = new URLRequest("http://www.imlol.eu/");
			navigateToURL(targetURL);
		}
		
		private function showMenu(event:MouseEvent):void {
			startMenu = true;
			play_mc.removeEventListener(MouseEvent.CLICK, showMenu);
		}
		
		private function introHandler(event:Event):void {
			var total:Number = stage.loaderInfo.bytesTotal;
			var loaded:Number = stage.loaderInfo.bytesLoaded;
			var loaderBar:MovieClip = loaderBar_mc;

			loaderBar.scaleX = loaded/total;
			loaderTxt.text = "Loaded " + loaded/1000 + " kB of " + total/1000 + " kB, " + Math.floor((loaded/total)*100) + "%";

			if(total == loaded) {
				trace("Game(ST): Game loaded, showing play button");
				play_mc.visible = true;
				stage.removeEventListener(Event.ENTER_FRAME,introHandler);
				play_mc.addEventListener(MouseEvent.CLICK, showMenu);
			}
		}
		
		// Story Methods:
		private var nextMsg:Boolean = true;
		private var msgArray:Array = new Array();
		private var msgCount:int = 0;
		
		private function storyInit():void {
			trace("Game(ST): Story started.");
			gotoAndStop(1,"Story");
			startStory = false;
			stage.focus = stage;
			setMsgArray();
			stage.addEventListener(KeyboardEvent.KEY_DOWN, storyKeyPressed);
			stage.addEventListener(Event.ENTER_FRAME,storyHandler);
		}
		
		private function storyKeyPressed(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.SPACE)
				nextMsg = true;
		}
		
		private function storyHandler(event:Event):void {
			if(nextMsg) {
				if(msgCount < msgArray.length) {
					msgTxt.text = msgArray[msgCount];
					nextMsg = false;
					msgCount++;
				} else
					startGame = true;
			}
				
			if(startGame) {
				stage.removeEventListener(Event.ENTER_FRAME,storyHandler);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, storyKeyPressed);
			}
		}
		
		private function setMsgArray():void {
			msgArray[0] = "*static sound*";
			msgArray[1] = "*communication unit sound*";
			msgArray[2] = "ISS to Astronaut Lloyd..";
			msgArray[3] = "Astronaut Lloyd.. come in..";
			msgArray[4] = "You regain consciousness and hear the sound of the com unit.";
			msgArray[5] = "ISS to Astronaut Lloyd.. come in..";
			msgArray[6] = "Astronaut Lloyd, you recently worked on the ISS, International Space Station, you were working on an experiment to test new forms of chemical reactions. During one of the experiments you accidentally mixed up the chemicals you were working with, everything went smooth until you added the final toxic substance."
			msgArray[7] = "The corrosive substance penetrated the CTRH-1, Chemical Testing Rack for Humans-1, walls and then spread through the Destiny Laboratory while continuously expanding. After spreading through half of the Destiny Lab, it caused an explosion which caused huge hull wreckage to rocket out by the explosion force.";
			msgArray[8] = "Some of this hit the solar panels of ISS causing huge damage. While other parts hit the Kibo Laboratory ejecting it from the ISS, and sent it drifting off towards the moon.";
			msgArray[9] = "After you noticed that the corrosive substance had started penetrating the CTRH-1, you had only thought of your own survival and stole one of the Space suits aboard the ISS and stole the highly advanced space ship which was docked to ISS.";
			msgArray[10] = "Due to this the World Government now suspects you are guilty of destroying the ISS, and have begun and universal search for you and the Space ship you stole. Forces have been allowed to fire on your space ship if you resist capture.";
			msgArray[11] = "Do not respond to the radio!";
			trace("Game(ST): Story messages set.");
		}
		
		// Game Methods:
		private var recharger:int = 0;
		private var spawnRate:int = 50;
		private var spawnCounter:int = 0;
		
		private var player:ship;
		private var leftWall:wall;
		private var rightWall:wall;
		private var hpBar:hpShield;
		private var shieldBar:hpShield;
		private var ammoBar:hpShield;
		private var leftHitBox:wall_hitBox;
		private var rightHitBox:wall_hitBox;
		
		private function GameInit():void {
			trace("Game(ST): GameEnv started.");
			gotoAndStop(1,"GameEnv");
			startGame = false;
		
			
			
			try {
				player = ship_mc;
				
				player.setFA(this);
				statusText.setFA(this);
				
				leftWall = leftWall_mc;
				rightWall = rightWall_mc;
				hpBar = hpBar_mc;
				shieldBar = shieldBar_mc;
				ammoBar = ammoBar_mc;
				leftHitBox = leftHitBox_mc;
				rightHitBox = rightHitBox_mc;
	
				leftHitBox.setWall(wall.LEFT_WALL);
				rightHitBox.setWall(wall.RIGHT_WALL);
				leftWall.setWall(wall.LEFT_WALL);
				rightWall.setWall(wall.RIGHT_WALL);
	
				hpBar.setPlayer(player);
				shieldBar.setPlayer(player);
				ammoBar.setPlayer(player);
				leftWall.setPlayer(player);
				rightWall.setPlayer(player);
				rightHitBox.setPlayer(player);
				leftHitBox.setPlayer(player);
				projectile.setPlayer(player);
				enemies.setPlayer(player);
				powerup.setPlayer(player);
				
				hpBar.setBarType(hpShield.HEALTH_BAR);
				shieldBar.setBarType(hpShield.SHIELD_BAR);
				ammoBar.setBarType(hpShield.AMMO_BAR);
				
				player.setHpBar(hpBar);
				player.setShieldBar(shieldBar);
				player.setAmmoBar(ammoBar);
				
				stats.setStatsMC(stats_mc,stage,player);

				
				stage.addEventListener(Event.ENTER_FRAME,addEnemy);
				trace("Game(ST): Class linking set, addEnemy started.");
			} catch(error:Error) {
				trace(error);
			}
		}
		
		private var spawns:int;
		
		private function addEnemy(event:Event):void {
			if(recharger == 0) {
				makeEnemy();
				recharger++;
				spawnCounter++;
				trace("Game(SC): enemies spawned " + spawnCounter );
			}
		
			if(recharger >= spawnRate)
				recharger = 0;
			if(recharger > 0)
				recharger++;
		}
		
		private function makeEnemy() {
			var sC:int = spawnCounter;
			switch(true) {
				case sC<5:
					spawnEnemy(1,111);
					break;
				case sC<10:
					spawnEnemy(2,131);
					break;
				case sC<15:
					spawnEnemy(2,121);
					break;
				case sC<20:
					spawnEnemy(2,141);
					break;
				case sC<25:
					spawnEnemy(2,131);
					break;
				case sC<30:
					spawnEnemy(2,121);
					break;
				case sC<35:
					spawnEnemy(1,131);
					break;
				case sC<40:
					spawnEnemy(2,141);
					break;
				case sC<45:
					spawnEnemy(2,131);
					break;
				case sC<50:
					spawnEnemy(1,141);
					break;
				case sC<55:
					spawnEnemy(3,161);
					break;
				case sC<60:
					spawnEnemy(3,151);
					break;
				case sC==60:
					spawnEnemy(1,600);
					new statusText(4,stage);
					break;
				/*case sC<65:
					spawnEnemy(1,70);
					break;
				case sC<70:
					spawnEnemy(2,111);
					break;
				case sC>70:
					spawnEnemy(3,121);
					break;*/
			}
		}
		
		private function spawnEnemy(spawnsIn:int,spawnRateIn:int) {
			spawns = spawnsIn;
			spawnRate = spawnRateIn;
			for(var i:int; i < spawns; i++) {
				new enemies(typeEnemy(),stage);
			}
		}
		
		private function typeEnemy():int {
			var sC:int = spawnCounter;
			var type:int;
			switch(true) {
				case sC<10:
					type = (int) (Math.random()*1)+1; //1
					break;
				case sC<20:
					type = (int) (Math.random()*2)+1; //1 2
					break;
				case sC<30:
					type = (int) (Math.random()*2)+1; //1 2
					break;
				case sC<40:
					type = (int) (Math.random()*3)+1; //1 2 3
					break;
				case sC<50:
					type = (int) (Math.random()*3)+2; //2 3 4
					break;
				case sC<60:
					type = (int) (Math.random()*3)+2; //2 3 4
					break;
				case sC == 60:
					type = (int) (Math.random()*1)+5; //5
					break;
				/*case sC<65:
					type = (int) (Math.random()*3)+2; //2 3 4
					break;
				case sC<70:
					type = (int) (Math.random()*3)+2; //2 3 4
					break;
				case sC>=70:
					type = (int) (Math.random()*3)+2; //2 3 4
					break;*/
			}
			
			return type;
		}
	}
}