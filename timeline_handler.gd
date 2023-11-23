extends Node2D

var frame_created = false
var timeline = []
var rewind_index = 0
var rewinding = false

func CreateFrame():
    timeline[GetTimelineLength()] = [] 

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
    rewind_index = GetTimelineLength()
    rewinding = true

func CheckRewind():
    if Input.is_action_pressed("Rewind"):
        StartRewind()

func ProcessRewind():
    pass