extends CharacterBody2D


var speed = 1.0
var last_direction = ""
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
		if abs(dirx) > abs(diry):
			last_direction = "right" if dirx > 0 else "left"
		else:
			last_direction = "down" if diry > 0 else "up"
		position += direction
	else:
		moving = false
	
	move_and_slide()

func animation():
	if velocity.x == 0 and velocity.y == 0:
		Anim.play("idle_" + last_direction)
