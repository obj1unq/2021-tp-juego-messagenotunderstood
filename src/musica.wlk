import wollok.game.*

object reproductor {
	
	method musicaMenu() {
		const track = game.sound("menuInicial.mp3")
		track.shouldLoop(true)
		track.volume(0.2)
		game.schedule(100,{track.play()})
		keyboard.enter().onPressDo({track.stop()})
	}
	
	method play(sound, time) {
		sound.volume(0.2)
		sound.play()
		game.schedule(time,{sound.stop()})
	}
	
	
}