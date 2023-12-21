extends Node3D

func _ready():
	$zombie14.set("visible",false)
	$zombie15.set("visible",false)
	$zombie16.set("visible",false)
	$zombie17.set("visible",false)
	$zombie18.set("visible",false)
	$zombie19.set("visible",false)
	$zombie20.set("visible",false)
	$zombie21.set("visible",false)
	$zombie22.set("visible",false)
	$zombie14/CollisionShape3D.disabled = true
	$zombie15/CollisionShape3D.disabled = true
	$zombie16/CollisionShape3D.disabled = true
	$zombie17/CollisionShape3D.disabled = true
	$zombie18/CollisionShape3D.disabled = true
	$zombie19/CollisionShape3D.disabled = true
	$zombie20/CollisionShape3D.disabled = true
	$zombie21/CollisionShape3D.disabled = true
	$zombie22/CollisionShape3D.disabled = true
	$zombie14.set("isStuck",true)
	$zombie15.set("isStuck",true)
	$zombie16.set("isStuck",true)
	$zombie17.set("isStuck",true)
	$zombie18.set("isStuck",true)
	$zombie19.set("isStuck",true)
	$zombie20.set("isStuck",true)
	$zombie21.set("isStuck",true)
	$zombie22.set("isStuck",true)
	
func _on_timer_timeout():
	$zombie14.set("visible",true)
	$zombie15.set("visible",true)
	$zombie16.set("visible",true)
	$zombie17.set("visible",true)
	$zombie18.set("visible",true)
	$zombie19.set("visible",true)
	$zombie20.set("visible",true)
	$zombie21.set("visible",true)
	$zombie22.set("visible",true)
	$zombie14/CollisionShape3D.disabled = false
	$zombie15/CollisionShape3D.disabled = false
	$zombie16/CollisionShape3D.disabled = false
	$zombie17/CollisionShape3D.disabled = false
	$zombie18/CollisionShape3D.disabled = false
	$zombie19/CollisionShape3D.disabled = false
	$zombie20/CollisionShape3D.disabled = false
	$zombie21/CollisionShape3D.disabled = false
	$zombie22/CollisionShape3D.disabled = false
	$zombie14.set("isStuck",false)
	$zombie15.set("isStuck",false)
	$zombie16.set("isStuck",false)
	$zombie17.set("isStuck",false)
	$zombie18.set("isStuck",false)
	$zombie19.set("isStuck",false)
	$zombie20.set("isStuck",false)
	$zombie21.set("isStuck",false)
	$zombie22.set("isStuck",false)
