import wollok.game.*
import elementos.*
import tanque.*
import defensa.*
import enemigos.*

object nivelUno {
	
	method iniciar() {	
		game.addVisual(tanque)
		game.addVisual(defensa)
		game.addVisual(enemigoLeopard)
		self.paredDefensa()
		enemigoLeopard.moverAleatorio()
	}	
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0)))
		game.addVisual(new Ladrillo(position = game.at(5,1)))
		game.addVisual(new Ladrillo(position = game.at(6, 1)))
		game.addVisual(new Ladrillo(position = game.at(7,1)))
		game.addVisual(new Ladrillo(position = game.at(7,0)))

	}
}