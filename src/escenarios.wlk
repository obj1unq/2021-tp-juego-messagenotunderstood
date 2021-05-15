import wollok.game.*
import elementos.*
import tanque.*
import defensa.*
import Enemigo.*

object nivelUno {
	
	method iniciar() {	
		self.paredDefensa()
		game.addVisual(tanque)
		game.addVisual(defensa)
		var enemigo = new Enemigo()
		game.addVisual(enemigo);
		game.onTick(1000,"moverEnemigo", {=> enemigo.moverAleatorio()})
		self.paredDefensa()
		self.paredDefensa()
	}	
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0)))
		game.addVisual(new Ladrillo(position = game.at(5,1)))
		game.addVisual(new Ladrillo(position = game.at(6, 1)))
		game.addVisual(new Ladrillo(position = game.at(7,1)))
		game.addVisual(new Ladrillo(position = game.at(7,0)))

	}
}