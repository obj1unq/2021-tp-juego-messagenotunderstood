import wollok.game.*

object musicaMenu {
	
	const property track = game.sound("menuInicial.mp3")
	
	method iniciar() {
		track.shouldLoop(true)
		game.schedule(100,{track.play()})
	}
	
	method stop() {
		game.schedule(100,{track.stop()})
	}
	
}