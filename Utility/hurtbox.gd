extends Area2D

@export_enum("coolDown", "hitOnce", "disableHitbox") var hurtBoxType = 0

@onready var collision = $CollisionShape2D
@onready var disableTimer = $DisableTimer

signal hurt(dmg)

func _on_area_entered(area):
	if area.is_in_group("attack"):
		if not area.get("dmg") == null:
			print("_on_area_entered")
			match hurtBoxType:
				0: #cooldown
					collision.call_deferred("set", "disabled", true)
					disableTimer.start()
				1: #hitOnce
					pass
				2: #disableHitbox
					if area.has_method("tempDisabled"):
						area.tempDisabled()
			var dmg = area.dmg
			emit_signal("hurt", dmg)
			if area.has_method("enemy_hit"):
				area.enemy_hit(1)
				
func _on_disable_timer_timeout():
	collision.call_deferred("set", "disabled", false)
	print("_on_disable_timer_timeout")
	

