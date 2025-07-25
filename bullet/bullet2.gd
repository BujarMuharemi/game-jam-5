extends Node2D

var direction = Vector2.ZERO
@export var speed = 1000
@export var lifetime = 3
@export var damage = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta: float) -> void:
	position += direction * speed * delta
