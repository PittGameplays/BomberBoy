extends CharacterBody2D

var speed = 90
var jump = 150
var max_jump = 250
var can_jump 
var gravity = 15
var is_big = false

@onready var Anim = $AnimatedSprite2D

func _physics_process(delta):
	movement()
	animation()

func movement():
	var direccion = Input.get_axis("btn_left","btn_right")
	velocity.x = direccion * speed
	
	if is_on_floor():
		velocity.y = 0
		$jump_time.stop()
		can_jump = true
	else:
		velocity.y += gravity
		if $jump_time.is_stopped():
			can_jump = false
	
	if Input.is_action_pressed("btn_jump") and can_jump:
		if $jump_time.is_stopped():
			$jump_time.start()
		velocity.y = -jump
	
	if Input.is_action_just_released("btn_jump"):
		can_jump = false
	move_and_slide()

func animation():
	if is_on_floor():
		if velocity.x != 0:
			Anim.play("walk")
			Anim.flip_h = velocity.x < 0
		else:
			Anim.play("idle")
	else:
		Anim.play("jump")

func player():
	pass


func _on_jump_time_timeout() -> void:
	can_jump = false


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().has_method("block"):
		can_jump = false
