extends Area2D

@export var dmg = 1

@onready var collision = $CollisionShape2D
@onready var disableTimer = $disableHitBoxTimer

func tempDisabled():
	collision.call_deferred("set", "disable", true)
	disableTimer.start()

func _on_disable_hit_box_timer_timeout():
	collision.call_deferred("set", "disable", false)
