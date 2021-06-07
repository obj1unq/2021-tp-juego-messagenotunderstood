import wollok.game.*
import elementos.*
import tanque.*
import config.*


object pantallaInicial {
	
	const property position = game.origin()
	
	method image() = "wollanzer.jpg"
	
	method iniciar() {
		game.addVisual(self)
		keyboard.enter().onPressDo({ nivelUno.iniciar() })
	}
}

class Nivel {
	method iniciar() {
		game.clear();
		self.paredDefensa();
		self.agregarObjetosIniciales();
		self.configurarTeclasYMecanismos();
	}
	
	method agregarObjetosIniciales(){
		game.addVisual(heroe)
		game.addVisual(defensa)
	}
	
	method configurarTeclasYMecanismos(){
		config.configurarTeclas()
		//config.configurarColisiones()
		config.configurarMovimientosYDisparosAleatoriosEnemigos()
	}
	
	method paredDefensa();
}

object nivelUno inherits Nivel{
	override method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(5,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(6, 1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,0), vida = 100))
	}
}

object nivelDos inherits Nivel{
	override method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(5,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(6, 1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,0), vida = 100))
	}
}

object nivelTres inherits Nivel{
	override method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(5,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(6, 1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,0), vida = 100))
	}
}

object nivelCuatro inherits Nivel{
	override method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(5,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(6, 1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,0), vida = 100))
	}
}