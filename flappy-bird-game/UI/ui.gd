extends CanvasGroup

class_name UI

@onready var points_display = $MarginContainer/PointsDisplay
@onready var gameover_screen = $MarginContainer/GameOver

func _ready():
	# reset points to 0
	points_display.text = "%d" % 0
	
func update_score(score: int):
	points_display.text = "%d" % score
	
func on_game_over():
	# shows game over screen
	gameover_screen.visible = true
	

func _on_button_pressed():
	get_tree().reload_current_scene()
