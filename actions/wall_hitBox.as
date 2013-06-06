package actions {
	
	import flash.display.*;
	import flash.events.*;
	
	public class wall_hitBox extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var LEFT_WALL:int = 1;
		public static var RIGHT_WALL:int = 2;
		
		// Private Properties:
		private var player:ship;
		private var type:int;
	
		// Initialization:
		public function wall_hitBox() {
			stage.addEventListener(Event.ENTER_FRAME, checkWallCollission);
			this.visible = false;
		}
		
		private function checkWallCollission(event:Event):void {
			if(player != null) {
				if(player.x < 120 || player.x > 480) {
					if(this.hitTestPoint(player.x+(player.width/2),player.y,true) && type == RIGHT_WALL)
						player.explode();
					if(this.hitTestPoint(player.x+(player.width/2),player.y+(player.height/2),true) && type == RIGHT_WALL)
						player.explode();
					if(this.hitTestPoint(player.x,player.y,true) && type == LEFT_WALL)
						player.explode();
					if(this.hitTestPoint(player.x,player.y+(player.height/2),true) && type == LEFT_WALL)
						player.explode();
					if(this.hitTestPoint(player.x-(player.width/2),player.y,true) && type == LEFT_WALL)
						player.explode();
				}
			}
			
			var enemy:Array = enemies.getEnemies();
			for(var i:int = 0; i < enemy.length; i++) {
				if(enemy[i] != null) {
					if(enemy[i].x < 120 || enemy[i].x > 480) {
						var exploded:Boolean = false;
						if(!exploded && this.hitTestPoint(enemy[i].x+enemy[i].width,enemy[i].y,true) && type == RIGHT_WALL)
							exploded = true;
						if(!exploded && this.hitTestPoint(enemy[i].x+enemy[i].width,enemy[i].y+enemy[i].height,true) && type == RIGHT_WALL)
							exploded = true;
						if(!exploded && this.hitTestPoint(enemy[i].x,enemy[i].y,true) && type == LEFT_WALL)
							exploded = true;
						if(!exploded && this.hitTestPoint(enemy[i].x,enemy[i].y+enemy[i].height,true) && type == LEFT_WALL)
							exploded = true;
							
						if(exploded)
							enemy[i].explode();
					}
				}
			}
			
			
			var power:Array = powerup.getPowerups();
			for(var g:int = 0; g < power.length; g++) {
				if(power[g] != null) {
					if(power[g].x < 120 || power[g].x > 480) {
						if(this.hitTestPoint(power[g].x,power[g].y,true) || this.hitTestPoint(power[g].x+power[g].width,power[g].y,true)) {
							trace("PowUp("+g+"): crashed into wall and exploded");
							new explosion(power[g],explosion.SMALL,stage);					
							power[g].remove();
						}
					}
				}
			}
			
			var proj:Array = projectile.getProjectiles();
			for(var p:int = 0; p < proj.length; p++) {
				if(proj[p] != null) {
					if(proj[p].x < 120 || proj[p].x > 480) {
						if(this.hitTestPoint(proj[p].x,proj[p].y,true) || this.hitTestPoint(proj[p].x+proj[p].width,proj[p].y,true)) {
							trace("Proje("+p+"): crashed into wall and exploded");
							new explosion(proj[p],explosion.SMALL,stage);					
							proj[p].remove();
						}
					}
				}
			}
		} //end Function
         	
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