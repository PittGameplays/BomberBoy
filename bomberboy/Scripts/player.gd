extends CharacterBody2D


var speed = 1.0
var last_direction = "down"
var moving = false
@onready var Anim:AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	movement()
	animation()

func movement():
	var dirx = Input.get_axis("btn_left", "btn_right")
	var diry = Input.get_axis("btn_up", "btn_down")
	var direction = Vector2(dirx * speed, diry * speed)
	if !direction.is_zero_approx():
		moving = true
		if abs(dirx) > abs(diry):
			last_direction = "right" if dirx > 0 else "left"
		else:
			last_direction = "down" if diry > 0 else "up"
		position += direction
	else:
		moving = false
	
	move_and_slide()

func animation():
	if !moving:
		if last_direction == "left":
			Anim.flip_h = true
			Anim.play("idle_right")
		else:
			Anim.play("idle_"+last_direction)
			Anim.flip_h = false
	else:
		if last_direction == "left":
			Anim.flip_h = true
			Anim.play("walk_right")
		else:
			Anim.play("walk_"+last_direction)
			Anim.flip_h = false
