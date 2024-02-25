extends Area2D
signal hit
@export var speed = 400
@export var pixelSpeedDist = 100
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("walk_up"):
		velocity.y -= pixelSpeedDist
	if Input.is_action_pressed("walk_down"):
		velocity.y += pixelSpeedDist
	if Input.is_action_pressed("walk_right"):
		velocity.x += pixelSpeedDist
	if Input.is_action_pressed("walk_left"):
		velocity.x -= pixelSpeedDist
		
	if velocity.length()> 0:
		velocity.normalized() * speed
		get_node("AnimatedSprite2D").play()
	else:
		get_node("AnimatedSprite2D").stop()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x != 0:
		if velocity.x < 0:
			$AnimatedSprite2D.animation = "walk_left"
		else :
			$AnimatedSprite2D.animation = "walk_right"
	elif velocity.y != 0:
		if velocity.y < 0:
			$AnimatedSprite2D.animation = "walk_up"
		else:
			$AnimatedSprite2D.animation = "walk_down"
	

# when the body of area2D entered something
func _on_body_entered(body):
	if body.is_in_group("mobs"):
		hide()
		hit.emit()
		get_node("CollisionShape2D").set_deferred("disabled", true) # Tell Godot to wait to disable the shape collisiton
	
	

func start(pos):
	position = pos
	
	show()
	$CollisionShape2D.disabled = false
