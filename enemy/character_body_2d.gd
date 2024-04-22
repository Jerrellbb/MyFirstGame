extends CharacterBody2D
@export var hp = 10

@export var movement_speed = 20.0

@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	move_and_slide()

func _on_hurtbox_hurt(dmg):
	hp -= dmg
	if hp < 0:
		queue_free()
	print(hp)
