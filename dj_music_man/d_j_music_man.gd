extends Node

var playback: AudioStreamPlaybackInteractive
@onready var music_player := %AudioStreamPlayer

func start() -> void:
	music_player.play()
	playback = music_player.get_stream_playback()

func play_start() -> void:
	if not music_player.playing: start()
	if playback.get_current_clip_index() == 0:
		return
	playback.switch_to_clip(0)

func play_full() -> void:
	if not music_player.playing: start()
	if playback.get_current_clip_index() == 1:
		return
	playback.switch_to_clip(1)

func stop() -> void:
	music_player.stop()
