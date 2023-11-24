extends Node2D

var frame_created = false
var timeline = []
var rewind_index = 0
var rewinding = false
var waitlist = {}
var frame_started = false

func FillWaitlist(_frame):
	print("Filling waitlist... Prior:{0}".format([waitlist]))
	waitlist = {}

	for action in _frame:
		waitlist[action["actor"].name] = false

	print("Filling waitlist... After:{0} ".format([waitlist]))

func CheckFrameDone():
	for key in waitlist.keys():
		if waitlist[key] == false:
			return false

	return true

func CreateFrame():
	timeline.append([])

func GetTimelineLength():
	return timeline.size()

func GetActionCount(_index):
	return timeline[_index].size()    

func AddAction(action):
	#Check if the frame has been created
	if !frame_created:
		CreateFrame()
		frame_created = true

	timeline[GetTimelineLength() - 1].append(action)

func StartRewind():
	rewind_index = GetTimelineLength() - 1
	rewinding = true

	#var frame = timeline[rewind_index]
	#FillWaitlist(frame)

	print("Starting Rewind...\nrewind_index: {0}".format([rewind_index]))

func CheckRewind():
	if Input.is_action_pressed("Rewind"):
		print("Rewind Triggered")
		StartRewind()

func ProcessRewind():
	if rewind_index >= 0:
		print("Remaining rewind: {0}".format([rewind_index]))

		if !frame_started:
			print("Frame Started: {0}\nStarting frame...".format([frame_started]))
			var frame = timeline[rewind_index]
			FillWaitlist(frame)

			print("Starting Actions for frame {0}...".format([frame]))
			for action in frame:
				print("Action: {0} -> {1} -> {2}".format([action["actor"], action["action type"], action["opposite_direction"]]))
				match action["action type"]:
					"Movement":
						var actor = action["actor"]
						actor.target_position = actor.position + action["opposite_direction"]
						actor.moving = true

			frame_started = true
		else:
			var done = CheckFrameDone()
			print("Is frame done?: {0}".format([done]))

			if done:
				print("We done with frame {0}".format([timeline[rewind_index]]))
				rewind_index -= 1
				frame_started = false
	else:
		print("rewind_index at {0} rewind ended.".format([rewind_index]))
		rewinding = false
		timeline = []
		waitlist = {}
