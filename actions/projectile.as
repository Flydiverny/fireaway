package actions {
	
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*;
	import flash.geom.*;
	
	public class projectile extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var EXAMPLE:int = 0;
		public static var WAVE:int = 1;
		public static var FIRE:int = 2;
		public static var MISSILE:int = 3;
		
		public static var FRIENDLY:int = 0;
		public static var ENEMY:int = 1;
		
		public static var RECHARGE:int = 0;
		public static var DAMAGE:int = 1;
		public static var SPEED:int = 2;
		public static var CHANNEL:int = 3;
		public static var SPAWNX:int = 4;
		public static var SPAWNY:int = 5;
		
		//[RECHARGE,DAMAGE,SPEED,CHANNEL]
		public static var EXAMPLE_SPECCS:Array = new Array(RECHARGE,DAMAGE,SPEED,CHANNEL,SPAWNX,SPAWNY);
		public static var WAVE_SPECCS:Array = new Array(15,20,2,0,-18,-12);
		public static var FIRE_SPECCS:Array = new Array(20,35,2,3,-8,-23);
		public static var MISSILE_SPECCS:Array = new Array(65,50,1.75,0,-5.5,-17);
		public static var projectiles:Array = new Array(EXAMPLE_SPECCS,WAVE_SPECCS,FIRE_SPECCS,MISSILE_SPECCS);

		// Private Properties:
		private var spawner:MovieClip;
		private static var player:ship;
		private var aStage:Stage;

		private var type:int;
		private var side:int = FRIENDLY;
		private var channeler:int = 0;
		
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var xFriction:Number = (1/6);
		private var yFriction:Number = (1/6);
		private var xPower:Number;
		private var yPower:Number;
		
		private var spwnXin:Number;
		private var spwnYin:Number;
		
		private static var tracker:Array = new Array();
		private static var count:int = 0;
		public var id:int;
		
		// Initialization:
		public function projectile(spawner:MovieClip,typeIn:int,spwnXin:Number,spwnYin:Number,side:int,stageIn:Stage) {
			this.aStage = stageIn;
			this.spawner = spawner;
			this.side = side;
			type = typeIn;
			this.spwnXin = spwnXin;
			this.spwnYin = spwnYin;
			
			xPower = projectiles[type][SPEED];
			yPower = projectiles[type][SPEED];
			
			if(side == ENEMY)
				this.rotation = 180;
			if(side == FRIENDLY)
				decreaseStats();
			
			if(side == FRIENDLY) {
				this.x = spawner.x + spwnXin + projectiles[type][SPAWNX];
				this.y = spawner.y + spwnYin + projectiles[type][SPAWNY];;
			}
			if(side == ENEMY) {
				this.x = spawner.x + spwnXin - projectiles[type][SPAWNX];
				this.y = spawner.y + spwnYin - projectiles[type][SPAWNY];
			}
			
			this.gotoAndStop(type);
				
			addTracker();
			aStage.addEventListener(Event.ENTER_FRAME, eventHandler,false,0,true);
		}
	
		// Public Methods:

		// Protected Methods:
		private function eventHandler(event:Event):void {
			if(channeler >= projectiles[type][CHANNEL]) {
				doMovement();
			} else {
				channeler++;
				if(side == FRIENDLY) {
					this.x = spawner.x + spwnXin + projectiles[type][SPAWNX];
					this.y = spawner.y + spwnYin + projectiles[type][SPAWNY];
				}
				if(side == ENEMY) {
					this.x = spawner.x + spwnXin - projectiles[type][SPAWNX];
					this.y = spawner.y + spwnYin - projectiles[type][SPAWNY];
				}
			}
			
			if(spawner != player) {
				if(this.hitTestObject(player)) {
					player.setHealth((projectiles[type][DAMAGE]/2),2);
					new explosion(this,explosion.SMALL,aStage);
					this.remove();
				}
			}
			
			if(spawner == player) {
				var enemy:Array = enemies.getEnemies();
				for(var i:int = 0; i < enemy.length; i++) {
					if(enemy[i] != null) {
						if(enemy[i].y+enemy[i].height-10 > 0 && enemy[i].y < this.y) {
							if(this.hitTestObject(enemy[i])) {
								enemy[i].setHealth(projectiles[type][DAMAGE],2);
								new explosion(this,explosion.SMALL,aStage);
								this.remove();
							}
						}
					}
				}
			}
			
			for(var k:int = 0; k < tracker.length; k++) {
				if(tracker[k] != null && tracker[k] != this) {
					if(tracker[k].getSide() != this.side) {
						if(this.hitTestObject(tracker[k])) {
							if(tracker[k].getProjType() == WAVE) {
								new explosion(this,explosion.SMALL,aStage);
								this.remove();
							} if(tracker[k].getProjType() == this.getProjType()) {
								new explosion(this,explosion.SMALL,aStage);
								tracker[k].remove();
								this.remove();
							}
						}
					}
				}
			}
			
			if(this.y < -50 || this.y > 650)
				this.remove();

			this.y += ySpeed;
			this.x += xSpeed;
		}
		
		public static function getProjRecharge(type:int):int {
			return projectiles[type][RECHARGE];
		}
		
		public function getProjType():int {
			return type;
		}
		
		public static function getProjDamage(type:int):int {
			return projectiles[type][DAMAGE];
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
			
			if(side == ENEMY)  
				trace("Proje("+id+"): spawned by ENEMY");
			if(side == FRIENDLY)
				trace("Proje("+id+"): spawned by FRIENDLY");
			
			aStage.addChild(this);
		}
		
		public function remove() {
			if(tracker[id] != null) {
				aStage.removeEventListener(Event.ENTER_FRAME, eventHandler);
				aStage.removeChild(this);
				tracker[id] = null;
				if(side == ENEMY)  
					trace("Proje("+id+"): removed by ENEMY");
				if(side == FRIENDLY)
					trace("Proje("+id+"): removed by FRIENDLY");
			}
		}
		
		public static function getProjectiles():Array {
			return tracker;
		}
		
		public function getSide():int {
			return side;
		}
		
		private function doMovement():void {
			switch(type) {
				case WAVE:
					defaultMovement();
					break;
				case FIRE:
					defaultMovement();
					break;
				case MISSILE:
					missileMovement();
					break;
			}
		}
		
		private function defaultMovement():void {
			if(side == FRIENDLY)
				ySpeed -= f(3);
			if(side == ENEMY)
				ySpeed += f(2);
		}
		
		private var targetSet:Boolean = false;
		private var target:enemies;
		
		private function missileMovement():void {
			target = getTarget();
			
			if(target != null || side == ENEMY) {
				var xTar:Number;
				var yTar:Number;
				if(side == FRIENDLY) {
					xTar = target.x + target.width/2;
					yTar = target.y + target.height/2;
				} else if (side == ENEMY) {
					xTar = player.x + player.width/2;
					yTar = player.y + player.height/2;
				}
				if(xTar > this.x) {
					xSpeed += f(0);
				} else if(xTar < this.x) {
					xSpeed -= f(1);
				}
				
				if(yTar > this.y) {
					ySpeed += f(2);
				} else if(yTar < this.y) {
					ySpeed -= f(3);
				}
			}
			else
				defaultMovement();
			
			setRotation();
		}
		
		private function setRotation():void {
			var tan:Number = 0;
			
			tan = Math.atan((ySpeed*-1)/xSpeed);
			tan = tan*(180/Math.PI);

			if(xSpeed < 0) {
				tan += 180;
			}

			this.rotation = (tan*-1) + 90;
		}
		
		private function getTarget():enemies {
			var enemy:Array = enemies.getEnemies();
			var lowWay:int;
			var curWay:int;
			var tarId:int;
			var tarMid:Point = new Point(0,0); 
			var tarFound:Boolean;

			if(side == FRIENDLY) {
				for(var i:int = 0; i < enemy.length; i++) {
					if(enemy[i] != null) {
						if(enemy[i].y+enemy[i].height-10 > 0 && enemy[i].y < 600) {
							tarMid.x = enemy[i].x+(enemy[i].width/2);
							tarMid.x = tarMid.x-this.x;
							tarMid.x = tarMid.x * tarMid.x;
							
							tarMid.y = enemy[i].y+(enemy[i].height/2);
							tarMid.y = tarMid.y-this.y;
							tarMid.y = tarMid.y * tarMid.y;
							
							curWay = tarMid.x + tarMid.y;
							
							if(curWay < lowWay || lowWay == 0) {
								lowWay = curWay;
								tarId = i;
								tarFound = true;
							}
						}
					}
				}
			} else if(side == ENEMY) {
				tarFound = false;
			}
			
			if(tarFound)
				return enemy[tarId];
			else
				return null;
		}
		
		private function f(what:int):Number {
			if(what == 0)
				return xPower-xFriction*xSpeed;
			else if(what == 1)
				return xPower+xFriction*xSpeed;
			else if(what == 2)
				return yPower-yFriction*ySpeed;
			else if(what == 3)
				return yPower+yFriction*ySpeed;
			else
				return 0;
		}
		
		private function decreaseStats():void {
			stats.projFired();
			
			switch(type) {
				case WAVE:
					new stats(player,-20);
					break;
				case FIRE:
					new stats(player,-10);
					break;
				case MISSILE:
					new stats(player,-50);
					break;
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