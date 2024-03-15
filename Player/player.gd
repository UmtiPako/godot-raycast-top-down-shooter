extends CharacterBody2D

@onready var rc = $RayCast2D
@export var move_speed = 200

var dead = false

func _process(delta):
	global_rotation = global_position.direction_to(get_global_mouse_position()).angle() + PI/2
	shoot()
	
func _physics_process(delta):
	movement()

func movement():
	if dead:
		return
	var move_dir = Input.get_vector("left","right","up","down")
	velocity = move_dir * move_speed
	move_and_slide()

func kill():
	if dead:
		return
	dead = true
	$DeathSound.play()
	z_index = -1

func shoot():
	if Input.is_action_just_pressed("shoot"):
		$MuzzleFlash.show()
		$MuzzleFlash/Timer.start()
		$ShootSound.play()
		if rc.is_colliding() and rc.get_collider().has_method("die"):
			rc.get_collider().die()
		
	
