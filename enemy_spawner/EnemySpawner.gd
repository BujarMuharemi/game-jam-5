extends Node

@export var enemy_scene: PackedScene
@export var spawnRate = 1
@export var spawnTime = 1

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(spawnTime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_enemy():
	
	for i in spawnRate:
		var enemy = enemy_scene.instantiate()
		#TODO: avoid spawning directly at player ! do it w/ vector code from player
		enemy.position.x += rng.randf_range(0, 1280)
		enemy.position.y += rng.randf_range(0, 720)
		#print(enemy.position)
		
		get_parent().add_child(enemy)

