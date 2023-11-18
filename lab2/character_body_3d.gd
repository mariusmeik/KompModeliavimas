extends CharacterBody3D

const MOVE_SPEED = 5
const JUMP_VELOCITY = 8
 
@onready var raycast = $RayCast3D
@onready var anim_player = $AnimationPlayer
@onready var zombieDeathSound = $zombieDiesSound
@onready var kraujas =$kraujas
@onready var timer = $Timer

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
var player = null
var dead = false
 
func _ready():
	anim_player.play("walk")
	add_to_group("zombies")
 
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta

	if dead or player == null:
		return

	var vec_to_player = player.global_transform.origin - global_transform.origin
	raycast.target_position = vec_to_player.normalized() * 1.5

	var direction = vec_to_player.normalized()
	if direction.length_squared() > 0.01:  # Check if the direction is not close to zero
		velocity.x = direction.x * MOVE_SPEED
		velocity.z = direction.z * MOVE_SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, MOVE_SPEED)
		velocity.z = move_toward(velocity.z, 0, MOVE_SPEED)

	move_and_slide()
 
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
	
func _on_timer_timeout():
	velocity.y = JUMP_VELOCITY
	timer.wait_time = randf_range(5, 15)
	timer.start()
