extends CharacterBody2D

var speed := 90
var jump := 280
var gravity := 10
var direccion := 0


func _physics_process(delta):
	direccion = Input.get_axis("btn_right","btn_left")
