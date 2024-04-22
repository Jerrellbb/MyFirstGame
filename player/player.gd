extends CharacterBody2D
@export var hp = 10

@export var movement_speed = 40.0
#attacks
var icespear = preload("res://player/attack/ice_spear.tscn")
#attack nodes
@onready var iceSpearTimer = get_node("%IceSpearTimer")
@onready var IceSpearAttackTimer = get_node("%IceSpearAttackTimer")

#iceSpear
var icespear_ammo = 0
var icespear_baseammo = 1
var icespear_attackspeed = 1.5
var icespear_level = 1

#enemy related
var enemy_close = []


func _ready():
	attack()
	
	


func _physics_process(_delta):
	movement()
	
func movement():
	var x_mov = Input.get_action_strength("right") - Input.get_action_strength("left")
	var y_mov = Input.get_action_strength("down") - Input.get_action_strength("up")
	var mov = Vector2(x_mov, y_mov)
	velocity = mov.normalized()*movement_speed
	move_and_slide()
	
func attack():
		if icespear_level > 0:
			iceSpearTimer.wait_time = icespear_attackspeed
			if iceSpearTimer.is_stopped():
				iceSpearTimer.start()

func _on_hurtbox_hurt(dmg):
	hp -= dmg
	


func _on_ice_spear_timer_timeout():
	icespear_ammo += icespear_baseammo
	IceSpearAttackTimer.start()


func _on_ice_spear_attack_timer_timeout():
	if icespear_ammo > 0:
		var icespear_attack = icespear.instantiate()
		icespear_attack.position = position
		icespear_attack.target = get_random_target()
		icespear_attack.level = icespear_level
		add_child(icespear_attack)
		icespear_ammo -= 1
		if icespear_ammo > 0:
			IceSpearAttackTimer.start()
		else:
			IceSpearAttackTimer.stop()
		
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP

func _on_enemy_detection_area_body_entered(body):
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body):
	if enemy_close.has(body):
		enemy_close.erase(body)
		
