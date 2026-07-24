class_name PatrolState
extends State

var current_route_node : Node2D
var route_nodes : Array
var current_route_node_idx : int = 0

var acceptable_distance : float = 20

var decreasing : bool = false
var face_walk_direction : bool = true

func _ready() -> void:
	super()
	#initialize route nodes
	if not get_patron().route:
		return
	route_nodes = get_patron().route.get_children()
	if route_nodes.is_empty():
		return
	route_nodes.sort_custom(names_ascending)
	current_route_node = route_nodes[0]
	
	
	
func names_ascending(node1, node2) -> bool:
	return int(node1.name) < int(node2.name)


func process_state(delta : float) -> void:
	if route_nodes.is_empty():
		return
	#move toward next route node
	
	var walk_direction : Vector2
	var desired_direction = get_patron().global_position.direction_to(current_route_node.global_position)
	if face_walk_direction:
		walk_direction = Vector2.RIGHT.rotated(get_patron().rotation)
	else:
		walk_direction = desired_direction
	get_patron().velocity = get_patron().walk_speed * walk_direction
	get_patron().move_and_slide()
	(get_patron() as Enemy).rotate_toward_direction(desired_direction, delta)
	if get_patron().global_position.distance_to(current_route_node.global_position) < acceptable_distance:
		advance_current_route_node()
		
		
func advance_current_route_node() -> void:
	if current_route_node_idx + 1 >= route_nodes.size():
		if (get_patron() as Enemy).patrol_mode == "loop":
			current_route_node_idx = 0
		else:
			current_route_node_idx -= 1
			decreasing = true
	else:
		if decreasing:
			current_route_node_idx -= 1
			if current_route_node_idx == 0:
				decreasing = false
			elif current_route_node_idx < 0:
				current_route_node_idx = 0
				decreasing = false
		else:
			current_route_node_idx += 1
	current_route_node = route_nodes[current_route_node_idx] 
