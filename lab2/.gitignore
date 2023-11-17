extends CharacterBody3D
 
const MOVE_SPEED = 4
const MOUSE_SENS = 0.5
 
@onready var anim_player = $AnimationPlayer
@onready var raycast = $RayCast3D
@onready var sprite = $CanvasLayer/Control/victory
@onready var gunshot =$gunshot

var killCount = 0
 
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	await get_tree().process_frame
	get_tree().call_group("zombies", "set_player", self)
 
func _input(event):
	if event is InputEventMouseMotion:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
 
func _process(delta):
	if Input.is_action_pressed("exit"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		kill()
 
func _physics_process(delta):
	var move_vec = Vector3()
	if Input.is_action_pressed("moveUp"):
		move_vec.z -= 1
	if Input.is_action_pressed("moveDown"):
		move_vec.z += 1
	if Input.is_action_pressed("moveLeft"):
		move_vec.x -= 1
	if Input.is_action_pressed("moveRight"):
		move_vec.x += 1
	move_vec = move_vec.normalized()
	move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
	move_and_collide(move_vec * MOVE_SPEED * delta)
 
	if Input.is_action_pressed("Shoot") and !anim_player.is_playing():
		gunshot.play()
		anim_player.play("shootAnimation")
		var coll = raycast.get_collider()
		if raycast.is_colliding() and coll.has_method("kill"):
			coll.kill()
			killCount = killCount + 1
	if killCount == 4:
		anim_player.play("win")
		sprite.visible = true
 
func kill():
	get_tree().reload_current_scene()
