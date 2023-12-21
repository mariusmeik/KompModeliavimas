extends CharacterBody3D

const MOVE_SPEED = 5
const JUMP_VELOCITY = 10
var health = 20
 
@onready var raycast = $RayCast3D
#@onready var anim_player = $AnimationPlayer
@onready var zombieDeathSound = $zombieDiesSound
@onready var kraujas1 =$kraujas
@onready var kraujas2 =$kraujas2
var jumping = false
var unstuck = false

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var kraujas = 2
var player = null
var dead = false
 
func _ready():
	#anim_player.play("walk")
	add_to_group("zombies")
 
func _physics_process(delta):
	if jumping:
		velocity.y = JUMP_VELOCITY
		jumping = false  # Reset jumping flag after applying jump velocity
		
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
	if unstuck:
		move_and_slide()
 
	if raycast.is_colliding():
		var coll = raycast.get_collider()
		if coll != null and coll.name == "Player":
			coll.kill()
 
func kill():
	health = health - 1
	kraujas1.emitting = true
	kraujas2.emitting = true
	if(health == 0):
		die()
		
func die():
	dead = true
	$LeftHandColider.disabled = true
	$RightHandColider.disabled = true
	$HeadColider.disabled = true
	$LegsColider.disabled = true
	$_mesh.visible = false
	zombieDeathSound.play()
	if kraujas==1:
		kraujas=2
		kraujas1.emitting = true
	else:
		kraujas=1
		kraujas2.emitting = true
	#anim_player.play("die")
 
func set_player(p):
	player = p

func _on_timer_timeout():
	print("veikia")
	jumping = true
	$Timer.wait_time = randf_range(5, 10)
	$Timer.start()

func _on_spawn_timer_timeout():
	print("laikas2")
	unstuck = true
	$LeftHandColider.disabled = false
	$RightHandColider.disabled = false
	$HeadColider.disabled = false
	$LegsColider.disabled = false
	$_mesh.visible = true
