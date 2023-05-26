extends Node

@export var enemy_scene: PackedScene
@export var enemy_spawnPoint: PackedScene

@export var spawnRate = 1
@export var spawnTime: float
@export var spanwTimeMinimizer = 0.10

var rng = RandomNumberGenerator.new()
var hud

func _ready():
	$Timer.set_wait_time(spawnTime)
	hud = get_parent().get_node("HUD")
	hud.connect("round_over",process_new_round)
	hud.connect("start_round",new_round)
	
	
func process_new_round(round):
	$Timer.stop()
	spawnTime=5.5
	spawnRate+=1
	spanwTimeMinimizer+=round/35.0
	print(">spawnRate: "+str(spawnRate))
	
func new_round(round):
	$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#spawnRate =  (get_parent().get_node("HUD").round_time*-1)

func spawn_enemy():
	print("#spawnTime: "+str(spawnTime))
	
	if(spawnTime>2.5):
		spawnTime-= spanwTimeMinimizer
	#print(spawnTime)
	for i in spawnRate:		
		var enemy = enemy_scene.instantiate()
		var enemyS = enemy_spawnPoint.instantiate()
		
		#TODO: avoid spawning directly at player ! do it w/ vector code from player
		enemy.position.x += rng.randf_range(0, 1600)
		enemy.position.y += rng.randf_range(0, 900)
		enemyS.position = enemy.position
		#print(enemy.position)
		
		get_parent().add_child(enemyS)
		$SpawnMarkerTimer.start()
		# https://gdscript.com/solutions/coroutines-and-yield/
		await $SpawnMarkerTimer.timeout 
		enemyS.queue_free()
		get_parent().add_child(enemy)

