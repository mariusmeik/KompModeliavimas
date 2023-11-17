extends CharacterBody3D

const MOVE_SPEED = 1
 
@onready var raycast = $RayCast3D
@onready var anim_player = $AnimationPlayer
@onready var zombieDeathSound = $zombieDiesSound
@onready var kraujas =$kraujas
 
var player = null
var dead = false
 
func _ready():
	anim_player.play("walk")
	add_to_group("zombies")
 
func _physics_process(delta):
	if dead:
		return
	if player == null:
		return
 
	var vec_to_player = player.position - position
	raycast.target_position = vec_to_player.normalized() * 1.5
 
	move_and_collide(vec_to_player * MOVE_SPEED * delta)
 
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()
 
 
func kill():
	dead = true
	$CollisionShape3D.disabled = true
	zombieDeathSound.play()
	kraujas.emitting = true
	anim_player.play("die")
 
func set_player(p):
	player = p
