package actions {
	
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.utils.*;
	import flash.text.*;
	import flash.geom.*;
	import flash.ui.*;

	public class ship extends MovieClip {
		
		// Constants:
		private var POSITIVE:int = 1;
		private var NEGATIVE:int = 2;
		
		// Public Properties:
		// Private Properties:
		private static var left:Boolean = false;
		private static var right:Boolean = false;
		private static var up:Boolean = false;
		private static var down:Boolean = false;
		private static var space:Boolean = false;
		
		private var ySpeed:Number;
		private var xSpeed:Number;
		private var xFriction:Number = 0.09;
		private var yFriction:Number = 0.09;
		private var xPower:Number = 1.5;
		private var yPower:Number = 1.2;
		
		private var respawnPoint:Point = new Point(374.5,573);
		
		private var exploding:Boolean = false;
		
		private var shield:int	= 100;
		private var health:int	= 100;
		private var maxHealth:int = 100;
		private var maxShield:int = 100;
		
		private var fireRate:int = 15;
		private var projType:int = projectile.WAVE;
		
		private var recharger:int = 0;
		
		private var can1x:Number = -18.5;
		private var can1y:Number = -13.5;
		private var can2x:Number = 17.5;
		private var can2y:Number = -13.5;
		private var can3x:Number = 0;
		private var can3y:Number = -25.5;
		
		private var dualCannon:Boolean;
		private var fR_boost:int = 0;
		private var life:int = 3;
		
		// UI Elements:
		private var hpBar:hpShield;
		private var shieldBar:hpShield;
		private var ammoBar:hpShield;
		
		private var FA:MovieClip;
		
		private var firstSpawn:Boolean = true;
		
		// Initialization:
		public function ship() {
			respawn();
			firstSpawn = false;
			stage.addEventListener(Event.ENTER_FRAME, moveShip);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			setProjectile(projectile.FIRE);
		}

		// Public Methods:
		public function explode():void {
			if(!exploding) {
				new explosion(this,explosion.BIG,stage);
				exploding = true;
				xSpeed = 0;
				ySpeed = 0;
				this.gotoAndPlay("explode");
			}
		}
		
		public function getHealth():int {
			return health;
		}
		
		public function getShield():int {
			return shield;
		}
		
		public function getMaxShield():int {
			return maxShield;
		}
		
		public function getMaxHealth():int {
			return maxHealth;
		}
		
		public function getMaxAmmo():int {
			return fireRate;
		}
		
		public function getAmmo():int {
			return recharger;
		}
		
		public function setHealth(hIn:int,addSub:int):void {
			if(getShield() > 0 && addSub == NEGATIVE) {
				setShield(hIn,addSub);
			}
			else {
				if(addSub == POSITIVE)
					health += hIn;
				if(addSub == NEGATIVE)
					health -= hIn;
				if(addSub == 3)
					health = maxHealth;
				if(health > maxHealth)
					health = maxHealth;
					
				if(health <= (maxHealth/100*45))
					new statusText(1,stage);
	
				hpBar.fillUp();
	
				if(health <= 0)
					explode();
	
				trace("Ship(HP): health changed by: " + hIn + " health is now: " + health);
			}
		}
		
		public function setShield(sIn:int,addSub:int):void {
			if(addSub == POSITIVE)
				shield += sIn;
			if(addSub == NEGATIVE)
				shield -= sIn;
			if(addSub == 3)
				shield = maxShield;
			if(shield > maxShield)
				shield = maxShield;
			
			if(shield <= 0)
				new statusText(3,stage);
			else if(shield <= (maxShield/100*45))
				new statusText(2,stage);
							
			if(shield < 0) {
				setHealth(shield,NEGATIVE);
				shield = 0;
			}
				
			shieldBar.fillUp();
		}
		
		public function setShieldBar(shieldBar:hpShield):void {
			this.shieldBar = shieldBar;
		}
		
		public function setHpBar(hpBar:hpShield):void {
			this.hpBar = hpBar;
		}
		
		public function setAmmoBar(ammoBar:hpShield):void {
			this.ammoBar = ammoBar;
		}
		
		// Protected Methods:
		
		// Private Methods:
		
		private function moveShip(event:Event):void {
			if(exploding)
				respawn();
			
			//Lower Block "Invis Wall"
			if(this.y > respawnPoint.y)
				this.y = respawnPoint.y;
			//Upper Block "Invis Wall"
			if(this.y < 10)
				this.y = 10;

			if(!exploding) {
				updateSpeed();
				changeDirection();
				fire();
			}
		}
		
		private var proj:Array = new Array();
		
		private function fire():void {
			var filling:Boolean = false;
			if(space) {
				if(recharger == fireRate) {
					fireProjectiles();
					
					recharger = 0;
					ammoBar.fillUp();
					filling = true;
				}
			}
			if(recharger > fireRate)
				recharger = fireRate;
			if(recharger < fireRate && !filling) {
				recharger++;
				ammoBar.fillUp();
			}
		}
		
		private function fireProjectiles():void {
			var dualFire:Boolean = false;
			
			switch(projType) {
				case projectile.FIRE:
					dualFire = true;
					break;
				case projectile.WAVE:
					dualFire = false;
					break;
				case projectile.MISSILE:
					dualFire = true;
					break;
			}
			
			if(dualCannon && dualFire) {
				var proj = new projectile(this,projType,can1x,can1y,projectile.FRIENDLY,stage);
				var proj2 = new projectile(this,projType,can2x,can2y,projectile.FRIENDLY,stage);
			} else
				var proj3 = new projectile(this,projType,can3x,can3y,projectile.FRIENDLY,stage);
		}
		
		public function skillUp(skillType:int):void {
			trace("Player(): skill up of type " + skillType + " added.");
			switch(skillType) {
				case powerup.WPN1:
					if(!dualCannon && fR_boost < 10)
						fR_boost++;
					else if(!dualCannon)
						dualCannon = true;
					else if(fR_boost < 15)
						fR_boost++;
					break;
				case powerup.WPN2:
					skillUp(powerup.WPN1);
					break;
				case powerup.HPUP:
					setHealth(25,POSITIVE);
					break;
				case powerup.HEALTH:
					maxHealth += 10;
					setHealth(maxHealth,3);
					break;
				case powerup.SPUP:
					setShield(25,POSITIVE);
					break;
				case powerup.SHIELD:
					maxShield += 10;
					setShield(maxShield,3);
					break;
			}
			
			setProjectile(projType);
		}
		
		private function setProjectile(projType:int):void {
			this.projType = projType;
			fireRate = projectile.getProjRecharge(projType);
			fireRate = fireRate-fR_boost;
			
			if(recharger > fireRate)
				recharger = fireRate;
			
			if(ammoBar != null)
				ammoBar.fillUp();
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
		
		private function updateSpeed():void {
			if(left)
				xSpeed -= f(1);
			if(right)
				xSpeed += f(0);
			if(up)
				ySpeed -= f(3);
			if(down)
				ySpeed += f(2);
			
			if(!up && !down && ySpeed != 0)
				ySpeedDec();
			if(!left && !right && xSpeed != 0)
				xSpeedDec();
				
			this.x += xSpeed;
			this.y += ySpeed;
		}
		
		private function xSpeedDec():void {
			if(xSpeed > 0) {
				xSpeed -= xFriction*xPower*7;
			}
			if(xSpeed < 0) {
				xSpeed += xFriction*xPower*7;
			}
			if(xSpeed < 1 && xSpeed > -1)
				xSpeed = 0;
		}
		
		private function ySpeedDec():void {
			if(ySpeed > 0) {
				ySpeed -= yFriction*yPower*7;
			}
			if(ySpeed < 0) {
				ySpeed += yFriction*yPower*7;
			}
			if(ySpeed < 1 && ySpeed > -1)
				ySpeed = 0;
		}
		
		private function changeDirection():void {
			if(xSpeed > 0 && !exploding)
				this.gotoAndStop("right");
			if(xSpeed < 0 && !exploding)
				this.gotoAndStop("left");
			if(xSpeed == 0 && !exploding)
				this.gotoAndStop("default");
		}
		
		private function respawn():void {
			if(health <= 0 || firstSpawn || exploding) {
				exploding = false;
				this.gotoAndStop("default");
				this.x = respawnPoint.x;
				this.y = respawnPoint.y;
				xSpeed = 0;
				ySpeed = 0;
				if(!firstSpawn) {
					setHealth(maxHealth,3);
					setShield(maxShield,3);
					life--;
					trace("Player(): died and lost life, life is now " + life);
				}
			}
			if(life == 1)
				new statusText(5,stage);
				
			if(life == 2)
				FA.life1.visible = false;
			else if(life == 1)
				FA.life2.visible = false;
			else if(life == 0)
				FA.life3.visible = false;

			if(life == 0) {
				new statusText(6,stage);
				stage.removeEventListener(Event.ENTER_FRAME, moveShip);
				stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
				stage.removeEventListener(KeyboardEvent.KEY_UP, keyReleased);
				up = false; down = false; left = false; right = false; space = false;
			}
		}
		
		public function setFA(FAIN:MovieClip):void {
			FA = FAIN;
		}
		
		private function keyPressed(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = true;
					break;
				case 39:
					right = true;
					break;
				case 38:
					up = true;
					break;
				case 40:
					down = true;
					break;
				case Keyboard.SPACE:
					space = true;
					break;
				case Keyboard.SHIFT:
					changeWeapon(1);
					break;
				case Keyboard.CONTROL:
					changeWeapon(2);
					break;
				case 49:
					setWeapon(1);
					break;
				case 50:
					setWeapon(2);
					break;
				case 51:
					setWeapon(3);
					break;
				/*case 52:
					setWeapon(4);
					break;*/
			}
		}
			
		private function keyReleased(event:KeyboardEvent):void {
			switch(event.keyCode) {
				case 37: 
					left = false;
					break;
				case 39:
					right = false;
					break;
				case 38:
					up = false;
					break;
				case 40:
					down = false;
					break;
				case Keyboard.SPACE:
					space = false;
					break;
			}
		}
		
		private function changeWeapon(up:int):void {
			var curWeapon:int = projType;
			var maxWpn:int = projectile.projectiles.length;

			if(up == 1) {
				curWeapon++;
				if(curWeapon == maxWpn)
					curWeapon = 1;
			}
			else if(up == 2) {
				curWeapon--;
				if(curWeapon == 0)
					curWeapon = maxWpn-1;
			}
			
			setProjectile(curWeapon);
		}
		
		private function setWeapon(which:int):void {
			switch(which) {
				case 1:
					new statusText(7,stage);
					break;
				case 2:
					new statusText(8,stage);
					break;
				case 3:
					new statusText(9,stage);
					break;
				case 4:
					which = 3;
					new statusText(10,stage);
					break;
			}
			
			setProjectile(which);
		}
	} //End Class
} //End package