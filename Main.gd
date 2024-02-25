extends Node
@export var mob_scene: PackedScene
var score

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$HUD.show_latest_score(score)
	
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	score = 0
	$Player.start($StartPosition2.position)
	$HUD/ScoreLabel.show()
	$HUD/LastScoreLabel.hide()
	$StartTimer.start()
	
	var hud = get_node("HUD")
	hud.update_score(score)
	hud.show_message("Get Ready")

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)
	

func _on_start_timer_timeout():
	get_node("MobTimer").start()
	get_node("ScoreTimer").start()


func _on_mob_timer_timeout():
	# Creat a new instance of a mob scene
	var mob = mob_scene.instantiate()
	
	mob.gravity_scale = 0
	
	# Choose a random location on Path2D assign the 
	# Progress to random
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	
		# Set the mob spawn location
	mob.position = mob_spawn_location.position
	
	# add random direction in radian (circle)
	direction += randf_range(-PI / 5, PI / 5)
	mob.rotation = direction
	
	# Choose the velocity for the mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding mob scene to the main scene it to the Main scenc
	add_child(mob)
	
	
func _ready():
	pass
	
	


func _on_hud_start_game():
	pass # Replace with function body.
