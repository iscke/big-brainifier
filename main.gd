extends Node2D

var min_speed : float
var max_speed : float
var spawn_interval : float

var timer := 0
var counter := 0

func _ready():
	$MinSpeed.drag_ended.connect(update_min)
	$MaxSpeed.drag_ended.connect(update_max)
	$SpawnInterval.drag_ended.connect(update_spawn)
	update_min(false)
	update_max(false)
	update_spawn(false)

	$StartButton.pressed.connect(start)
	$StopButton.pressed.connect(stop)

	$ResetButton.pressed.connect(reset)
	$ClearButton.pressed.connect(clear)

	$Spawner.timeout.connect(spawn)
	$Clock.timeout.connect(clock)

func spawn():
	$ThoughtSpawner.spawn(min_speed, max_speed)
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