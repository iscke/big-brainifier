extends Node2D

var min_speed : float
var max_speed : float
var fast_min : float
var fast_max : float
var fast_chance : float
var spawn_interval : float

var timer := 0
var counter := 0

func _ready():
	$MinSpeed.value_changed.connect(update_min)
	$MaxSpeed.value_changed.connect(update_max)
	$FastMinSpeed.value_changed.connect(update_fast_min)
	$FastMaxSpeed.value_changed.connect(update_fast_max)
	$FastChance.value_changed.connect(update_fast_chance)
	$SpawnInterval.value_changed.connect(update_spawn)
	update_min(false)
	update_max(false)
	update_spawn(false)
	update_fast_min(false)
	update_fast_max(false)
	update_fast_chance(false)

	$StartButton.pressed.connect(start)
	$StopButton.pressed.connect(stop)

	$ResetButton.pressed.connect(reset)
	$ClearButton.pressed.connect(clear)

	$Spawner.timeout.connect(spawn)
	$Clock.timeout.connect(clock)

func spawn():
	$ThoughtSpawner.spawn(min_speed, max_speed, fast_min, fast_max, fast_chance)
	counter += 1
	update_stats()

func clock():
	timer += 1
	update_stats()

func clear():
	get_tree().call_group("thoughts", "queue_free")

func start():
	spawn()
	$Spawner.start()
	$Clock.start()

func stop():
	$Spawner.stop()
	$Clock.stop()

func update_min(a):
	min_speed = $MinSpeed.value
	$MinLabel.text = "min speed: " + str(min_speed)

func update_max(a):
	max_speed = $MaxSpeed.value
	$MaxLabel.text = "max speed: " + str(max_speed)

func update_fast_min(a):
	fast_min = $FastMinSpeed.value
	$FastMinLabel.text = "fast thought min speed: " + str(fast_min)

func update_fast_max(a):
	fast_max = $FastMaxSpeed.value
	$FastMaxLabel.text = "fast thought max speed: " + str(fast_max)

func update_fast_chance(a):
	fast_chance = $FastChance.value
	$FastChanceLabel.text = "fast thought chance: " + str(fast_chance*100) + "%"

func update_spawn(a):
	spawn_interval = $SpawnInterval.value
	$Spawner.wait_time = spawn_interval
	$SpawnLabel.text = "spawn interval: " + str(spawn_interval)

func reset():
	timer = 0
	counter = 0
	update_stats()

func update_stats():
	$TimeLabel.text = "time: %02d:%02d" % [int(timer/60), timer % 60]
	$ThoughtsLabel.text = "thoughts: " + str(counter)
