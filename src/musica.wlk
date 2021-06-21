import wollok.game.*

object musicaMenu {
	
	const property track = game.sound("menuInicial.mp3")
	
	method play() {
		track.shouldLoop(true)
		track.volume(0.2)
		if(!track.paused()) {
			game.schedule(100,{track.play()})
		} else {
			track.resume()
		}
	}
	
	method pause() {
		game.schedule(100,{track.pause()})
	}
	
}


object reproductor {
	
	method play(sound, time) {
		sound.volume(0.2)
		sound.play()
		game.schedule(time,{sound.stop()})
	}
}