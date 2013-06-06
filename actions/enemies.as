package actions {
	
	import flash.display.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.ui.*;

	public class enemies extends MovieClip {
		
		// Constants:
		private var aStage:Stage;
		private static var player:ship;
		
		public static var HEALTH:int = 0;
		public static var SHIELD:int = 1;
		public static var XSPEED:int = 2;
		public static var YSPEED:int = 3;
		public static var PROJECTILE:int = 4;
		public static var FIRERATE:int = 5;
		public static var CAN1X:int = 6;
		public static var CAN1Y:int = 7;
		public static var CAN2X:int = 8;
		public static var CAN2Y:int = 9;
		public static var DUALCAN:int = 10;
		
		public static var TYPE1:int = 1;
		public static var TYPE2:int = 2;
		public static var TYPE3:int = 3;
		public static var TYPE4:int = 4;
		public static var BOSS:int = 5;

		public static var POSITIVE:int = 1;
		public static var NEGATIVE:int = 2;
		
		
		// Public Properties:
		// Private Properties:
		
		private var ySpeed:Number = 0;
		private var xSpeed:Number = 0;
		private var xFriction:Number = 0.09;
		private var yFriction:Number = 0.5;
		private var xPower:Number;
		private var yPower:Number;
		private var ranX:int = (int) (Math.random()*440+180);
		private var respawnPoint:Point = new Point(ranX,-125);
		
		private var exploding:Boolean = false;
		
		private var shield:int = 0;
		private var health:int = 25;
		
		public static var EXAMP_SPECCS:Array = new Array(HEALTH,	SHIELD,	XSPEED,	YSPEED,	PROJECTILE,	FIRERATE,	CAN1X,	CAN1Y,	CAN2X,	CAN2Y,	DUALCAN);
		public static var TYPE1_SPECCS:Array = new Array(15,		0,		0.7,	1,			2,			60,			25.5,	51,		0,		0,		0);
		public static var TYPE2_SPECCS:Array = new Array(20,		0,		2,		1,			2,			40,			25.5,	51,		0,		0,		0);
		public static var TYPE3_SPECCS:Array = new Array(50,		0,		0.7,	0.5,		2,			35,			7,		65,		52,		65,		1);
		public static var TYPE4_SPECCS:Array = new Array(50,		0,		0.5,	0.7,		1,			30,			7,		65,		52,		65,		1);
		public static var BOSS_SPECCS:Array = new Array	(2000,		0,		3,		0.1,		3,			40,			7,		65,		52,		65,		1);
		public static var enemy:Array = new Array(EXAMP_SPECCS,TYPE1_SPECCS,TYPE2_SPECCS,TYPE3_SPECCS,TYPE4_SPECCS,BOSS_SPECCS);
		
		private var type:int;
		
		private var fireRate:int;
		private var projType:int;
		private var recharger:int = 0;
		
		private static var tracker:Array = new Array();
		private static var count:int = 0;
		public var id:int;
		
		// Initialization:
		public function enemies(typeIn:int,stageIn:Stage) {
			aStage = stageIn;
			aStage.addEventListener(Event.ENTER_FRAME, moveShip,false,0,true);
			
			setType(typeIn);

			this.x = respawnPoint.x;
			this.y = respawnPoint.y;
			
			addTracker();
		}

		// Public Methods:
		public function explode():void {
			if(!exploding) {
				exploding = true;
				new explosion(this,explosion.BIG,aStage);
				stats.enemyKilled();
				powerup.spawn(this,aStage);
				remove();
			}
		}
		
		public function getHealth():int {
			return health;
		}
		
		public function getShield():int {
			return shield;
		}
		
		public function setHealth(hIn:int,addSub:int):void {
			if(addSub == POSITIVE)
				health += hIn;
			if(addSub == NEGATIVE)
				health -= hIn;

			if(health <= 0)
				explode();
				
			trace("Enemy(" +id+ "): health changed by: " + hIn + " health is now: " + health);
		}
		
		public function setShield(sIn:int,addSub:int):void {
			if(addSub == POSITIVE)
				shield += sIn;
			if(addSub == NEGATIVE)
				shield -= sIn;
		}
		
		// Protected Methods:
		
		// Private Methods:
		private function moveShip(event:Event):void {
			if(!exploding) {
				updateSpeed();
				changeDirection();
				fire();
			}
			
			if(this.hitTestObject(player)) {
				player.explode();
				explode();
			}
			if(this.y >= 650)
				remove();
			if(this.x < 0 || this.x > 600 || this.y < -250) {
				trace("Enemy(" +id+ "): bad spawn loc x: " + this.x + " y: " + this.y);
				//new enemies(aStage);
			}
		}
		
		private var proj:Array = new Array();
			
		private function fire():void {
			if(this.y+(this.height/2) > 0) {
				if(recharger == 0) {
					spawnProjectile();
					recharger++;
				}
				if(recharger >= fireRate)
					recharger = 0;
				if(recharger > 0)
					recharger++;
			}
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
		
		private var duration:int = 0;
		private var durCount:int = 0;
		private var durSet:Boolean = false;
		
		private function updateSpeed():void {
			var ran:int;
			if(this.x < 110) {
				ran = 1;
				durSet = false;
			} else if(this.x > 490) {
				ran = 2;
				durSet = false;
			} else {
				ran = (int) (Math.random()*2)+1;
			}

			if(durCount >= duration || !durSet) {
				if(ran == 2)
					xSpeed -= f(1);
				if(ran == 1)
					xSpeed += f(0);
					
				duration = (int) (Math.random()*60)+20;
				durCount = 0;
				durSet = true;
				
				trace("Enemy(" +id+ "): xSpeed set to " + xSpeed);
			}

			ySpeed += f(2);
			
			durCount++;
			this.x += xSpeed;
			this.y += ySpeed;
		}
		
		private function changeDirection():void {
		}
		
		public function setType(typeIn:int):void {
			type = typeIn;
			this.gotoAndStop(type);
			health = enemy[type][HEALTH];
			shield = enemy[type][SHIELD];
			xPower = enemy[type][XSPEED];
			yPower = enemy[type][YSPEED];
			projType = enemy[type][PROJECTILE];
			fireRate = enemy[type][FIRERATE];
		}
		
		public static function setPlayer(playerIn:ship) {
			player = playerIn;
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
			
			trace("Enemy(" +id+ "): spawned");
			
			aStage.addChild(this);
		}
		
		public function remove() {
			if(type != BOSS)
				new stats(this,100*type);
			if(type == BOSS) {
				new stats(this,5000);
				new statusText(6,stage);
			}

			aStage.removeEventListener(Event.ENTER_FRAME, moveShip);
			aStage.removeChild(this);
			tracker[id] = null;
			
			trace("Enemy(" +id+ "): removed");
		}
		
		public static function getEnemies():Array {
			return tracker;
		}
		
		private function spawnProjectile():void {
			if(enemy[type][DUALCAN] == 0) {
				var proj = new projectile(this,projType,enemy[type][CAN1X],enemy[type][CAN1Y],projectile.ENEMY,aStage);
			}
			else if(enemy[type][DUALCAN] == 1) {
				var proj1 = new projectile(this,projType,enemy[type][CAN1X],enemy[type][CAN1Y],projectile.ENEMY,aStage);
				var proj2 = new projectile(this,projType,enemy[type][CAN2X],enemy[type][CAN2Y],projectile.ENEMY,aStage);
			}
		}
		
		public static function gameOver():void {
			for(var i:int = 0; i < tracker.length; i++) {
				if(tracker[i] != null)
					tracker[i].remove();
			}
		}
				
	} //End Class
} //End package