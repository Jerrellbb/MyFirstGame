extends CharacterBody2D
@export var hp = 10

@export var movement_speed = 20.0
@onready var sprite = $Sprite2D
@export var knockback_recovery = 3.5
var knockback = Vector2.ZERO
@onready var player = get_tree().get_first_node_in_group("player")
@onready var snd_hit = $snd_hit
signal remove_from_array(object)

var death_anim = preload("res://enemy/explosion.tscn")

func _physics_process(_delta):
	knockback = knockback.move_toward(Vector2.ZERO, knockback_recovery)
	var direction = global_position.direction_to(player.global_position)
	velocity = direction*movement_speed
	velocity += knockback
	move_and_slide()



func death():
	emit_signal("remove_from_array", self)
	var enemy_death = death_anim.instantiate()
	enemy_death.scale =  sprite.scale * 20
	enemy_death.global_position = global_position
	get_parent().call_deferred("add_child", enemy_death)
	queue_free()
	
func _on_hurtbox_hurt(dmg, angle, knockback_amount):
	hp -= dmg
	knockback = angle * knockback_amount
	if hp <= 0:
		death()
	else:
		snd_hit.play()
