extends CanvasLayer
signal start_game

const GAME_OVER = "Game Over"
const RESTART = "Play it again !"
const READY_MESSAGE = "Ready"


func show_message(text):
	var showing_message = get_node("Message")
	showing_message.text = text
	showing_message.show()
	
	var message_timer = get_node("MessageTimer")
	message_timer.start()
	

func show_game_over():
	show_message(GAME_OVER)
	$ScoreLabel.hide()
	$LastScoreLabel.show()
	var message_timer = get_node("MessageTimer")
	var message = get_node("Message")
	var start_button = get_node("StartButton")
	
	# Await like js , wait unti the message timer counter down
	await message_timer.timeout
	
	await get_tree().create_timer(1.0).timeout
	
	start_button.show()
	

func update_score(score):
	var score_label = get_node("ScoreLabel")
	# get the text field from scorelabel
	
	# get the val from text field then
	# convert it to string
	score_label.text = str(score)

func show_latest_score(score):
	var latest_score_label = get_node("LastScoreLabel")
	var final_score = get_node("LastScoreLabel/FinalScore")
	final_score.text = str(score)
	
	

func _on_start_button_pressed():
	# Hide the start button then show the gameplay
	var start_button = get_node("StartButton")
	start_button.hide()
	
	# Start the gameplay by
	# Emitting the signal out
	start_game.emit()
	

# Hide the message of after the timer count is out
func _on_message_timer_timeout():
	var title_message = get_node("Message")
	title_message.hide()
