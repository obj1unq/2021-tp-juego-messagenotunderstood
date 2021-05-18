import wollok.game.*
import elementos.*
import tanque.*
import enemigos.*

object nivelUno {
	
	method iniciar() {	
		self.paredDefensa()
		self.AgregarObjetosIniciales()
		enemigoLeopard.moverDisparandoAleatorio()
	}	
	
	method AgregarObjetosIniciales(){
		game.addVisual(tanque)
		game.addVisual(defensa)
		game.addVisual(enemigoLeopard)	
	}
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0)))
		game.addVisual(new Ladrillo(position = game.at(5,1)))
		game.addVisual(new Ladrillo(position = game.at(6, 1)))
		game.addVisual(new Ladrillo(position = game.at(7,1)))
		game.addVisual(new Ladrillo(position = game.at(7,0)))

	}
}