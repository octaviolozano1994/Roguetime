extends Node2D

var rewinding = false
var timeline = []   
var timeline_index = 0
var timeline_frame = 0

func _ready():
    randomize()  # Optional: randomize for any random number generation

func _process(delta):
    if not rewinding:
        update_timeline()
        check_rewind()
    else:
        rewind_time(delta)

func check_rewind():
    if Input.is_action_pressed("Rewind"):
        start_rewind()

func start_rewind():
    var timeline_size = timeline.size()
    if timeline_size > 0:
        timeline_index = timeline_size - 1
        rewinding = true

func update_timeline():
    timeline_frame += 1

func rewind_time(delta):
    if timeline_index >= 0:
        var frame = timeline[timeline_index]

        if(frame.size() == 0):
            #If the frame is empty skip it
        else:
            for action in frame:
                var action_type = action["Action Type"]
                match action_type:
                    "Movement":
                        process_movement_action(action, delta)
                    "Battle Start":
                        process_battle_start_action(action)
                    "Item Pickup":
                        process_item_pickup_action(action)
                    # Add more action types here as needed

            # Check if all actions in the frame are completed
            if are_all_actions_completed(frame):
                timeline_index -= 1  # Move to the previous frame
    else:
        rewinding = false
        clear_timeline()

func clear_timeline():
    timeline.clear()

func process_movement_action(action, delta):
    var actor = action["Actor"]
    var target_position = action["Target Position"]
    
    if actor.position != target_position:
        var direction = (target_position - actor.position).normalized()
        actor.position += direction * actor.speed * delta
        if actor.position.distance_to(target_position) < 1:
            actor.position = target_position  # Snap to the target position

    action["Completed"] = actor.position == target_position

func process_battle_start_action(action):
    # Implement logic to undo battle start

func process_item_pickup_action(action):
    # Implement logic to undo item pickup

func are_all_actions_completed(frame):
    for action in frame:
        if not action["Completed"]:
            return false
    return true