import wollok.game.*
import elementos.*
import tanque.*
import defensa.*
import enemigos.*

object nivelUno {
	
	method iniciar() {	
		game.addVisual(tanque)
		//game.addVisual(Bala)
		game.addVisual(defensa)
		game.addVisual(enemigoLeopard)
		self.paredDefensa()
		enemigoLeopard.moverAleatorio()
		self.paredDefensa()
	}	
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(11,0)))
		game.addVisual(new Ladrillo(position = game.at(11,1)))
		game.addVisual(new Ladrillo(position = game.at(14,3)))
		game.addVisual(new Ladrillo(position = game.at(17,1)))
		game.addVisual(new Ladrillo(position = game.at(17,0)))

	}
}