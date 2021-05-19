import wollok.game.*
import elementos.*
import tanque.*
import config.*

object nivelUno {
	
	method iniciar() {	
		self.paredDefensa()
		self.agregarObjetosIniciales()
		self.configurarTeclasYMecanismos()
	
	}	
	
	method agregarObjetosIniciales(){
		game.addVisual(tanque)
		game.addVisual(defensa)
		//game.addVisual(enemigoLeopard)	
	}
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0)))
		game.addVisual(new Ladrillo(position = game.at(5,1)))
		game.addVisual(new Ladrillo(position = game.at(6, 1)))
		game.addVisual(new Ladrillo(position = game.at(7,1)))
		game.addVisual(new Ladrillo(position = game.at(7,0)))

	}
	
	method configurarTeclasYMecanismos(){
		config.configurarTeclas()
		config.configurarColisiones()
		config.configurarMovimientosYDisparosAleatoriosEnemigos()
	}

}