import wollok.game.*
import elementos.*
import tanque.*
import defensa.*
import enemigos.*

object nivelUno {
	
	method iniciar() {	
		self.paredDefensa()
		game.addVisual(tanque)
		game.addVisual(defensa)
		game.addVisual(enemigoLeopard)	
		enemigoLeopard.moverDisparandoAleatorio()
	}	
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0)))
		game.addVisual(new Ladrillo(position = game.at(5,1)))
		game.addVisual(new Ladrillo(position = game.at(6, 1)))
		game.addVisual(new Ladrillo(position = game.at(7,1)))
		game.addVisual(new Ladrillo(position = game.at(7,0)))

	}
}