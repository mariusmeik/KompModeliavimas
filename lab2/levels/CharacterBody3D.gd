extends CharacterBody3D
const SPEED = 5.0
var mouseSensibility = 1500
var mouse_relative_x = 0
var mouse_relative_y = 0
const JUMP_VELOCITY = 4.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
 
@onready var anim_player = $AnimationPlayer
@onready var raycast = $Camera3D/RayCast3D
@onready var sprite = $CanvasLayer/Control/victory
@onready var gunshot =$gunshot
@onready var Cam = $Camera3D
@export var _bullet_scene : PackedScene

var killCount = 0
 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().process_frame
	get_tree().call_group("zombies", "set_player", self)
 
func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		kill()
 
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Handle Shooting
	if Input.is_action_pressed("Shoot") and !anim_player.is_playing():
		shoot()
 
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("moveLeft", "moveRight", "moveUp", "moveDown")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x / mouseSensibility
		Cam.rotation.x -= event.relative.y / mouseSensibility
		Cam.rotation.x = clamp(Cam.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)

func kill():
	get_tree().reload_current_scene()
	
func shoot():	
	gunshot.play()
	anim_player.play("shootAnimation")
	var coll = raycast.get_collider()
	if raycast.is_colliding():
		var bulletInst = _bullet_scene.instantiate() as Node3D
		bulletInst.set_as_top_level(true)
		get_parent().add_child(bulletInst)
		bulletInst.global_transform.origin = raycast.get_collision_point() as Vector3
		bulletInst.look_at((raycast.get_collision_point()+ raycast.get_collision_normal()),Vector3.BACK)
		print(raycast.get_collision_point())
		print(raycast.get_collision_point()+ raycast.get_collision_normal())
		if coll.has_method("kill"):
			coll.kill()
			killCount = killCount + 1
	if killCount == 8:
		anim_player.play("win")
		sprite.visible = true
