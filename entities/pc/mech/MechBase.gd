extends Sprite2D

@onready var _left_leg_animation: AnimatedSprite2D = $MechLegLeft
@onready var _right_leg_animation: AnimatedSprite2D = $MechLegRight

func play_walking_animation():
	_left_leg_animation.play("forward");
	if (_left_leg_animation.frame == 4 && _right_leg_animation.is_playing() != true):
		_right_leg_animation.play("forward");

func pause_walking_animation():
	_left_leg_animation.pause()
	_right_leg_animation.pause()
