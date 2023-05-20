extends Node

@export var enemy_scene: PackedScene
@export var enemy_spawnPoint: PackedScene

@export var spawnRate = 1
@export var spawnTime = 1

var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.set_wait_time(spawnTime)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#spawnRate =  (get_parent().get_node("HUD").round_time*-1)

func spawn_enemy():

	for i in spawnRate:
		var enemy = enemy_scene.instantiate()
		var enemyS = enemy_spawnPoint.instantiate()
		
		#TODO: avoid spawning directly at player ! do it w/ vector code from player
		enemy.position.x += rng.randf_range(0, 1280)
		enemy.position.y += rng.randf_range(0, 720)
		enemyS.position = enemy.position
		#print(enemy.position)
		
		get_parent().add_child(enemyS)
		
		
		get_parent().add_child(enemy)

