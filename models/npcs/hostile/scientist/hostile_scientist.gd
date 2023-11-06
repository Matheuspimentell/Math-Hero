extends CharacterBody2D
signal hasFoundPlayer

@export var stateMachine: StateMachine
@export var dialogue: CanvasLayer

var hasFinishedPreBattleDialogue = false

# If a player has entered the detection area and the current state is the Idle state
func _on_detection_area_body_entered(body):
	if body.name.to_lower() == "player" and stateMachine.current_state.name.to_lower() == "idle":
		hasFoundPlayer.emit()
		stateMachine.current_state.Transition.emit(stateMachine.current_state, "follow")

# If the follow state has reached the player
func _on_reached_player():
	if not hasFinishedPreBattleDialogue:
		dialogue.start_dialogue()
	else:
		return

func _on_finished_dialogues():
	hasFinishedPreBattleDialogue = true
	print("Begin the battle!")
	return
