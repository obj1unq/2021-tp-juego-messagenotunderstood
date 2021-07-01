import wollok.game.*

object reproductor {
	
	method playMusicaMenu() {
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
	
	method playDisparo() {
		const disparo = game.sound("cañon.mp3")
		self.play(disparo, 1000)
	}
	
	method playQuejido() {
		const doh = game.sound("doh.mp3")
		self.play(doh, 1000)
	}
	
	method playNivelSuperado() {
		const triunfo = game.sound("MetalSlug.mp3")
		self.play(triunfo, 7000)
	}
	
	method playFestejo() {
		const festejo = game.sound("woohoo.mp3")
		self.play(festejo, 1000)
	}
	
}