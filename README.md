# Navigation Capsule Lecture

## Step 1: Add a Navigation Layer

* Open the `tiles` scene
* Open the TileSet resource in the tilemap, and expand the "Navigation Layers" option
* Add a navigation layer element
* Open the TileSet editor, select a tile, and add a navigation polygon (either using the "Paint" option or drawing it like we draw the collision polys).  Only give navigation to one tile.
* Save the scene

## Step 2: Create a path and add your follower

* Open the `map` scene
* Draw out tiles, but make sure that the color of tile you gave the navigation polygon is contiguous (you can make it like a maze)
* Instance the `folower` scene as a child of Map, and put it on one of your tiles with navigation enabled
* Save your scene

## Step 3: Give the follower the ability to pathfind

* Open the `follower` scene
* Add a `NavigationAgent2D` node as a child of the root node
* Add a script to the Follower with the following code (from <https://docs.godotengine.org/en/stable/tutorials/navigation/navigation_introduction_2d.html>)

```python
extends CharacterBody2D

var movement_speed: float = 200.0
# Change this to be somewhere on your navigation path
var movement_target_position: Vector2 = Vector2(60.0,180.0)

@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

func _ready():
	# These values need to be adjusted for the actor's speed
	# and the navigation layout.
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0

	# Make sure to not await during _ready.
	call_deferred("actor_setup")

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	set_movement_target(movement_target_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.target_position = movement_target

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector2 = global_position
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
```
* Save everything and run your `map` scene.  What seems to be happening

## Step 4: Explore

Play around with different options (add an obstacle, for example).  Perhaps we'll play with mouse clicks in class to determine the next path

Consider: how might we force the navigation polygon to stay in the center of the grid? Is this trivial or hard?