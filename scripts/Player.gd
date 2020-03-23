extends KinematicBody2D

var velocity = Vector2()
const speed = 200
var sprite
var hand

func _ready():
	sprite = $AnimatedSprite
	hand = $hand

func _physics_process(delta):
	mouvement(delta)
	move_and_slide(velocity)
	if velocity == Vector2(0,0):
		sprite.stop()

func mouvement(delta):
	velocity = Vector2()
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		sprite.play("run")
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		sprite.play("run")
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		sprite.play("run")
		sprite.set_flip_h(true)
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		sprite.play("run")
		sprite.set_flip_h(false)
	velocity = velocity.normalized() * speed
