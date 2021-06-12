import wollok.game.*
import menuSuperior.*
import elementos.*
import tanque.*
import config.*


object pantallaInicial {
	
	const property position = game.origin()
	method image() = "wollanzer2.jpg"
	
	method iniciar() {
		game.addVisual(self)
		keyboard.enter().onPressDo({ nivelUno.iniciar() })
	}
}


object menuSuperiorInfoDelJuego{
	
	method estadoDelNivel(){
		game.addVisual(self)
	}	
	
}

class Nivel {
	
	
	method iniciar() {
		game.clear()
		self.paredDefensa()
		self.agregarObjetosIniciales()
		self.configurarTeclasYMecanismos()
		self.mapa()
	}	
	
	method agregarObjetosIniciales(){
		game.addVisual(heroe)
		game.addVisual(defensa)
	}
	
	method paredDefensa(){
		game.addVisual(new Ladrillo(position = game.at(5,0), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(5,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(6, 1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,1), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(7,0), vida = 100))
	}
	
	method configurarTeclasYMecanismos(){
		config.configurarTeclas()
		//config.configurarColisiones()
		config.configurarMovimientosYDisparosAleatoriosEnemigos()
	}
	
	method mapa() {
		self.agregarCharcos()
		self.agregarLadrillos()
		self.agregarPastizales()
		self.agregarMetales()
	}
	
	method agregarCharcos() 
	
	method agregarLadrillos() 
	
	method agregarPastizales() 

	method agregarMetales()
}

object nivelUno inherits Nivel {
	
	override method agregarCharcos() {
		//definir posiciones de elementos agua
		game.addVisual(new Agua(position = game.at(0,5)))
		game.addVisual(new Agua(position = game.at(1,5)))
		game.addVisual(new Agua(position = game.at(2,5)))
		game.addVisual(new Agua(position = game.at(12,8)))
		game.addVisual(new Agua(position = game.at(11,8)))	
		game.addVisual(new Agua(position = game.at(10,8)))
	}
	
	override method agregarLadrillos() {
		//definir posiciones para los ladrrilos
		game.addVisual(new Ladrillo(position = game.at(1,7), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(2,7), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(3,7), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(8,4), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(9,4), vida = 100))
		game.addVisual(new Ladrillo(position = game.at(10,4), vida = 49))
		game.addVisual(new Ladrillo(position = game.at(2,10), vida = 49))
		game.addVisual(new Ladrillo(position = game.at(2,4), vida = 49))
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		//definir posiciones para los ladrrilos
		game.addVisual(new Metal(position = game.at(6,12)))
		game.addVisual(new Metal(position = game.at(6,11)))
		game.addVisual(new Metal(position = game.at(6,10)))
		game.addVisual(new Metal(position = game.at(6,9)))
	}
}

object nivelDos inherits Nivel {
	
	override method agregarCharcos() {
		//definir posiciones de elementos agua	
	}
	
	override method agregarLadrillos() {
		//definir posiciones para los ladrrilos
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		//definir posiciones para los ladrrilos
		
	}
}


object ultimoNivel inherits Nivel{
	
	override method agregarCharcos() {
		//definir posiciones de elementos agua	
	}
	
	override method agregarLadrillos() {
		//definir posiciones para los ladrrilos
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		//definir posiciones para los ladrrilos
		
	}
}


object nivelActual {
	
	var property nivel = nivelUno
	
	method estado() {
		if (self.seGanoNivel()) {self.estadoDelJuego()}
	}
	
	method estadoDelJuego() {
		if (self.quedanNiveles()) {self.pasarDeNivel()}
		 else {self.victory()}
	}
	
	method pasarDeNivel() {
		self.nivelSiguiente()
		nivel.iniciar()
	}
	
	method quedanNiveles() {
		return nivel != ultimoNivel
	}
	
	method nivelSiguiente() { //mejorar con alguna visual y delay
	if (nivel == nivelUno) {nivel = nivelDos}
//	 else if (nivel == nivelDos) {nivel = nivelTres}
	  else nivel = ultimoNivel
	}
	
	method reStartSiPuede() { //mejorar con alguna visual y delay
		if (heroe.leQuedanVidas()) {nivel.iniciar()}
		 else {self.gameOver()}
	}
	
	method victory() {
		//agregar imagen de victoria y que vuelva a pantalla inicial al apretar cualquier tecla
	}
	
	method gameOver() {
		//agregar imagen de fin del juego y que vuelva a pantalla inicial al apretar cualquier tecla
	}
	
	method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == 15
	}
	
}