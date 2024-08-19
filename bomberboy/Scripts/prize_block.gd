extends StaticBody2D

@export var prize:PackedScene
@onready var Anim = $AnimatedSprite2D

func _ready() -> void:
	Anim.play("idle")

func _physics_process(delta: float) -> void:
	pass


func throw_prize():
	if prize == null:
		prize = preload("res://Scenes/brick.tscn")
	var prize_instant = prize.instantiate()
	get_tree().root.call_deferred("add_child", prize_instant)
	prize_instant.global_position = global_position
	var limit = prize_instant.global_position.y-16
	while prize_instant.global_position.y > limit:
		prize_instant.global_position.y -= 1 
	Anim.play("empty")
	Anim.pause()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player") and Anim.is_playing():
		throw_prize()

func block():
	pass
