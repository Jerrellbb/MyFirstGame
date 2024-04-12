extends Area2D


@export_enum("coolDown", "hitOnce", "disableHitbox") var hurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer
signal hurt(dmg)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("dmg") == null:
			match hurtBoxType:
				0: #cooldown
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1: #hurtOnce
					pass
				2: #disableHitbox
					if area.has_method("tempDisabled"):
						area.tempDisabled()
			var damage = area.dmg
			emit_signal("hurt", damage)

func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
	

