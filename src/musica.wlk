import wollok.game.*

object musicaMenu {
	
	const property track = game.sound("menuInicial.mp3")
	
	method iniciar() {
		track.shouldLoop(true)
		track.volume(0.3)
		game.schedule(100,{track.play()})
	}
	
	method stop() {
		game.schedule(100,{track.stop()})
	}
	
}

class SoundDisparo {
	
	const property sound = game.sound("cañon.mp3")
	
	method reproducirDisparo() {
		sound.volume(0.3)
		sound.play()
		game.schedule(800,{sound.stop()})
	}
}