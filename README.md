Changelog for FireAway, Made by Markus Maga

Beta 1.3
	- Set break multiplier to x7 instead of x2.
	- NG edition is now only Edition (Nick only instead of RL name).

Beta 1.2
	- Boss spawn is actually last enemy spawn now.
	- Enemy X spawn location is now wider, and fine tuned.

Beta 1.1
	- Weapon 4 temporarliy removed, due to it actually not existing.

Beta 1.0
	- Game is no longer Alpha, ver 1.5 becomes Beta 1.0

Alpha 1.5
	- KeyBooleans should now all be set to false upon GameOver.
	- HP power ups should now only affect HP and not shield.
	- Player can now see amount of lifes.

Alpha 1.4
	- Added GameOver scene.
	- GameOver scene shows score, proj fired, enemies killed.
	- Actionlisteners should now be removed on game over.
	- SpawnCounter now reset upon GameOver.
	- Scores are now reset upon GameOver.
	- Story msgCount set to 0 upon GameOver.
	- No more spawns after boss spawn.
	- Game now ends after Boss is removed.
	- GameOver screen now shows after statusText.
	- valueText from bars will now be removed when gameOver.
	
Alpha 1.3
	- Moved respawn y for player ship.
	- Enemies now start firing when half the ship is inside visual area.
	- Decreased max powerups with 5.
	
Alpha 1.2
	- Changed so hpShieldTiles now get inparameter of type instead of using setType.
	- Shield value is now only changed if its NEGATIVE health in setHealth.
	- Wider spawn loc range for enemies.
	
Alpha 1.1
	- Spawns after Boss, is no longer bosses.
	- Stage now gets focus when Story is init, so you can simply click space.
	- Most enemies use Pulse Cannon now.	
	- Changed PowerUps cordination position. (Now rotates around center point).
	- Changed ship xy to center position as well.
	- Changed Missile xy to center position.
	- Fixed Wall Hitbox to new ship xy
	- Increased player firerate.
	
Alpha 1.0
	- Game is no longer Pre-Alpha, ver 5.5 becomes Alpha 1.0
	
Pre-Alpha 5.5
	- Power up no longer move randomly.
	- Power ups now rotate in 1 direction only, twice speed.
	- You can now use the keybindings 1-4 to switch weapons (wpn type 4 still not added).
	- More StatusTexts added.
	- Shield is now properly refilled after respawn.
	- AmmoBar should now properly refill when changing to a projectile with lower recharge.
	- AmmoBar should no longer be able to 'overfill'.
	- PowerUps should no longer increase fireRate boost beyond 25 points.
	- Max firerate boost should no longer show 2 times the boost.
	- Player ship now spawns properly centered and fully in the screen.
	- Modified spawn rates and spawn amounts.
	- Rebalanced projectile recharges again.
	- Enemy Projectiles now deal half damage compared to player projectiles.
	- Score Counter added to right wall.
	- Stats class added.
		- Score gained will be shown at target and fade.
		- Score lost shown on player, in red.
		- Score gained/lost grows in and shrinks fading out.
	
Pre-Alpha 5.4
	- Warning / Status Message implementzed.
	- Shield is now in use for Player Ship, yet no animation.
	- Shield is now refilled upon death.
	- Added "boss", unbalanced.
	- Added new graphic for power up.
	- Lowered PowerUp spawn rate a little, high enough for testing purpose.
	- Modified projectile balancing.
	- Powerups now move randomly, and may change rotation direction.
	- Powerups can now explode if they hit the wall.
	
Pre-Alpha 5.3
	- Controls added.
	- Same method now handles all menu buttons.
	
Pre-Alpha 5.2
	- Menu added
	- Credits added
	- Shield bar now got same tiles as Health/Ammo.
	
Pre-Alpha 5.1
	- Tested rotating on HP/SHIELD/AMMO bar.
	- BlueFire channeling back to normal.
	- Missiles now hits for 50 dmg down from 100 dmg.
	- Missiles recharge is now 80 up from 40.
	- Comparssions between tile positioning, for feedback.
	- Powerups can nolonger spawn outside of screen.
	- Bars now got a text showing values above them.
	
Pre-Alpha 5.0
	- Changed play_mc to a button, added hover color.
	- play_mc actionListener is now removed after use.
	- Intro actionListener now removed after loading finished, instead of at button click.
	- Many many changes to Enemy spawning, now easily configure able.
	- Cannon locations on Enemy type 3 and 4 fixed.
	
Pre-Alpha 4.9
	- Version text now shows properly.
	
Pre-Alpha 4.8
	- Added Lifes in Code. ('GameOver' isn't doing anything).
	- Added code for DualCannon (Powerup support).
	- Added code for SkillUp (powerup support).
	
Pre-Alpha 4.7
	- You can now click to Play after PreLoading.
	- Version text can now be changed from fireAway class.
	- Music reEnabled for testing with preload.
	- Frame rate back to 30 FPS.

Pre-Alpha 4.6
	- New Logo
	- Ver listed on Intro Screen.
	- Copyright added
	- PreLoader added
	- PreLoader scene removed and implemented in Intro scene.
	- Frame rate set to 120 for BG testing.
	- BG set to one layer again.
	
Pre-Alpha 4.5
	- Missiles are now Slower.
	- Missiles now recharge slower.
	- Changed Star Background
	- Made 2 layer StarBg.
	- Enemies can now use Missiles.
	- Player will now die if health goes under 0, instead of only at exact 0 health.
	- Enemies can now fire with dual cannons.
	- Player can now swap between all weapons.
	
Pre-Alpha 4.4
	- Ship rotation removed.
	- Missile rotation improved.
	- Missiles are now slower.

Pre-Alpha 4.3
	- Music disabled cuz of whiny testing brother.
	- Missilez now rotate in the direction they are going.
	- Missile now has a working targeting.
	- Ship and Missile rotation is testing mode, fail build.
	
Pre-Alpha 4.2
	- Speeds are now  abit recalculated to fit for the Speed Formula.
	- Build for testing Missiles, dmg set to 1 and recharge set to 1.

Pre-Alpha 4.1
	- Projectiles now move by speed Formula.
	- Enemies now use the speed Formula properly in Y axis.
	
Pre-Alpha 4.0
	- Missiles won't lock on targets outside of screen.
	- Missiles can now change target.
	- Missiles will now have a default movement if no target is found.
	- Targets can now only be hit if 10 px of the ship are shown.
	- Projectile collission now causes a small explosion.
	- Missiles now have a unique look.
	
Pre-Alpha 3.9
	- Added possability to spawn power ups.
	- Added 2 new Enemy types, with the same graphic, one spams PROJ1 other PROJ2.
	- Enemies now move in the Y axis by the speed formula as well.
	- Enemies now got Cannons.
	- Missiles implemented.
	
Pre-Alpha 3.8
	- Removed Channeling on Wave
	- Added Cannon location for Enemy Ship TYPE1 and TYPE2
	- Enemies can now be hit even if its not fully visible.
	- Enemies now have a random X spawn location again.
	- This build got 120 fps for some testing.
	
Pre-Alpha 3.7
	- Projectiles now explode upon hitting asteroidez.
	- wall hitTests will now only be performed when inside the width.
	- Projectiles won't hit other projectiles from the same side.
	- Started reworking spawn location for projectiles.
	- Player ship now got 3 'cannons' (projectile spawn locations).
	- Unfinished build.
	
Pre-Alpha 3.6
	- Enemies now explode upon touching the Asteroid wall.
	- Changed graphic for player and enemy ships.
	- Enemies now move by the same formula as player ship.
	- Very minor enemy variation spawn system added.
	- Added small explosion animation for projectiles.
	- Spawning enemies now requires type inparameter.
	- Rewrote most traces to better show whats happening.
	- Enemy health, speed, projectiles, shield is now type specific.
	- Enemies shouldnt be able to get close enough to wall to crash.

Pre-Alpha 3.5
	- Enemy ships now explode when colliding with player ships.
	- Enemies now actually explodes upon death.
	- Merged setProjectile with getProjectileInfo in ship class.
	- Reimplemented Automatic SpeedDecreaser for player ship, new code.
	
Pre-Alpha 3.4
	- Health is now refilled after respawning for real.
	- MemLeak test in Debug mode performed on this version. Everything seems fine.
	
Pre-Alpha 3.3
	- Removed 'flickering' on AmmoBar.
	- Added Explosions class.
	- Ships now explode when hit.
	- Health is now refilled after respawning.
	
Pre-Alpha 3.2
	- Added "Press 'space' to continue" in Story Scene.
	- Added AmmoBar.
	- Improved fillUp code for bars.
	- Added maxHealth and maxShield vars.
	
Pre-Alpha 3.1
	- Improved Scene handling code.
	- Added code for Scenes to be added later on.
	- Created simple code for Story Scene.
	- Set Story Scene in use.
	- "Talker" text in Story scene is place holder.

Pre-Alpha 3.0
	- Removed unused function getEnemies() in fireAway.
	- Added getEnemies() to Enemies.
	- Updated getEnemies call in projectiles so projectiles can hit enemies again.
	- Renamed enemies array in projectiles to enemy due to name collission with class enemies.

Pre-Alpha 2.9
	- Added Story Scene, (not in use yet).
	- Turned on Battle Music again, lowered volume.
	- Removed possible memory leak on Enemy and Projectile spawning.
	- Enemies and projectiles now add them self to stage.
	- Tweaked and removed unnessecary code for enemies and projectiles spawning.

Pre-Alpha 2.8
	- Removed unused SpeedDec vars in Enemies class.
	- Removed unused Timer var in Projectiles class.
	- Slightly improved tracker code in projectiles.
	- Added tracker code to enemies based on projectiles tracker code.
	- Enemies now remove themself when they leave the visual area.
		- Enemies remove tracker in fireAway have therefore been removed.
	- Player nolonger loses Health when exploding (as this would be a death).

Pre-Alpha 2.7
	- Removed unused Timer var in Enemies class & old commented code.
	- Removed unnessecary this.visible from Enemies constructor.
	- Improved setShield handling code in enemies class to mimic setHealth.
	- Improved setShield & setHealth code in player class to mimic enemies class.
	- Made temporary change to respawn() in ship, so respawn only when health <= 0 or exploding.
	- Removed SpeedDecreaser codes in ship/player class.
	- Player now loses HEALTH when hit by a projectile, instead of exploding.

Pre-Alpha 2.6
	- Enemies now lose HEALTH when hit by a projectile.
	- Projectiles now deal actual DAMAGE to Enemy ships.
	- Projectiles now despawn after hitting an Enemy.
	- Projectiles now despawn after hitting Player ship, instead of jumping out of screen.
	  (Enemy projectile trackers removed projectiles out of visual area before).
	- Improved setHealth handling code in enemies class.
	- WAVE damage increased to 10.
	- FIRE damage increased to 25.
	- Enemies current HEALTH set to 25.

Pre-Alpha 2.5
	- Projectiles are now tracked by an ID in projectile class.
	- Projectiles can now collide.
		- WAVE projectiles defeat FIRE projectiles.
		- Equal projectiles kills each other.
	- Projectiles now remove themself when they leave the visual area.
		- Projectile trackers for Enemies and Player have therefore been removed.

Pre-Alpha 2.4
	- Player projectiles can now hit Enemy ships.
	- Some code improvements to allow more GC and avoid some MemLeaks.

Pre-Alpha 2.3
	- Found memory leak in earlier builds, so this build got higher spawn rate and fire rate.
	  to easier see if there is some memory leak or lagg after some running time.
	- Possibly some memory leak removed, and some decreased.

Pre-Alpha 2.2
	- Moved spawn point of enemy projectiles.
	- Rotated enemy projectiles so they won't be fired reversed.
	- Enemy ships will be destroyed if they crash with player ship.

Pre-Alpha 2.1
	- Player can now be hit by Enemy projectiles.
		- Enemy projectiles can't hit enemies.

Pre-Alpha 2.0
	- Changes to Enemy Ships
		- Spawning now works.
		- Movement now works.
		- Enemies can now fire.

Pre-Alpha 1.9
	- Changes to Enemy spawning.
		- Moved spawn to bottom of stage, to see if they were having reverse speed.
		- Still bugged, and flashing away but code improved.

Pre-Alpha 1.8
	- Added small intro
	- Added Enemy ships.
		- Bugged Spawning.
	- Made background animation a Movie Clip.
	- Reversed background to 1 layer.
	- Greatly improved Movements of player ship.
		- Faster Acceleration and a Max Speed.
		- Easier to turn change direction.

Pre-Alpha 1.7
	- Added 2nd Firing projectile FIRE (blue).
	- Swap projectiles with CTRL and SHIFT.
	- Redesigned WAVE projectile.
	- Added Y limits so Player cant leave screen anymore.
		
Pre-Alpha 1.6
	- Added 2nd layer for Background animation.
		- 2nd layer isnt looping properly.
	- Added Firing ability (press Space).

Pre-Alpha 1.5
	- Star sky background added, moving, scripted.
	- Hit boxes for side walls hidden.
	- Added support for losing Health and Shield (try crashing in wall.

Pre-Alpha 1.4
	- Attempts to fix better movements, failed.
		- Left and Right movements hardly working.
	- Removed Automatic Speed Decreasers.

Pre-Alpha 1.3
	- Side wall HitBoxes improved. (Red shows hitBox)
	- Movement Speeded up.
	- Health and Shield bars filled. (by code)
	- Player movement stops when its Exploding.

Pre-Alpha 1.2
	- Health and Shield bars added.

Pre-Alpha 1.0
	- Basic Movement
		- Includes "turning" of ship/player.
		- Automatic Speed Decreaser.
	- Side Walls.
	- Explosion effect on ship/player death.