package actions {
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class hpShield extends MovieClip {
		
		// Constants:
		// Public Properties:
		public static var HEALTH_BAR:int = 1;
		public static var SHIELD_BAR:int = 2;
		public static var AMMO_BAR:int = 3;
		
		// Private Properties:
		private var player:ship;
		private var type:int = HEALTH_BAR;
		private var tiles:Array = new Array();
		
		private var valueText:TextField = new TextField();
		
		private var max:Array = new Array();
	
		// Initialization:
		public function hpShield() {
			valueText.text = "TEST";
			valueText.x = this.x-105;
			valueText.y = this.y-8;
			valueText.autoSize = TextFieldAutoSize.RIGHT;

            var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0xFFFFFF;
            format.size = 8;

            valueText.defaultTextFormat = format;

			stage.addChild(valueText);
			valueText.visible = true;
		}
		
		public function removeValueTxt():void {
			stage.removeChild(valueText);
		}
		
		// Public Methods:
		public function setPlayer(player:ship):void {
			this.player = player;
		}
		
		public function setBarType(barIn:int):void {
			type = barIn;
			this.gotoAndStop(type);
			fillUp();
		}
		
		// Protected Methods:
		public function fillUp():void {
			if(ship != null) {
				max[AMMO_BAR] = player.getMaxAmmo();
				max[HEALTH_BAR] = player.getMaxHealth();
				max[SHIELD_BAR] = player.getMaxShield();
				var current:Number = 0;
				var perTile:Number = 0;
				var newTiles:Number = 0;
				if(type == HEALTH_BAR)
					current = player.getHealth();
				if(type == SHIELD_BAR)
					current = player.getShield();
				if(type == AMMO_BAR)
					current = player.getAmmo();

				perTile = max[type]/20;
				newTiles = current/perTile;

				for(var k:int = 0; k < tiles.length; k++) {
					if(tiles[k] != null)
						removeChild(tiles[k]);
						
					tiles[k] = null;
				}

				for(var i:int = 0; i < newTiles; i++) {
					tiles[i] = new hpShieldTiles(type);
					tiles[i].x = 4.5;
						tiles[i].y = 43-i*2;
					tiles[i].visible = true;
					addChild(tiles[i]);
				}
				
				this.valueText.text = current+"/"+max[type];
			}
		}
	}
}