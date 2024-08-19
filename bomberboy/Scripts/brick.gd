extends StaticBody2D

@onready var Anim = $AnimatedSprite2D

func _ready() -> void:
	Anim.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		if body.is_big:
			self.queue_free()

func block():
	pass
