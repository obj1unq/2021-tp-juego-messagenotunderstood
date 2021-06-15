import wollok.game.*
import menuSuperior.*
import elementos.*
import tanque.*
import config.*
import tanque.*

object pantallaInicial {
	
	const property position = game.origin()
	method image() = "wollanzer2.jpg"
	
	method iniciar() {
		game.addVisual(self)
		keyboard.enter().onPressDo({ nivelUno.iniciar() })
	}
}




class Nivel {
	
	
	method iniciar() {
		game.clear()
		self.paredDefensa()
		self.agregarObjetosIniciales()
		self.configurarTeclasYMecanismos()
		//self.estadoDelNivel()
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
	
	method seGanoNivel()
}

object nivelUno inherits Nivel {
	
	override method agregarCharcos() {

		gestorDeElementos.generarFilaDeAguaDesdeConTamanio(5,2)
		gestorDeElementos.generarColumaDeAguaDesdeConTamanio(9,4)
	}
	
	override method agregarLadrillos() {
		gestorDeElementos.generarFilaDeLadrillosDesdeConTamanio(10,5)	
		gestorDeElementos.generarColumaDeLadrillosDesdeConTamanio(3,7)	
	}
	
	override method agregarPastizales() {
		
	}
	
	override method agregarMetales() {
		gestorDeElementos.generarColumaDeMetalDesdeConTamanio(10,3)
		gestorDeElementos.generarFilaMetalDesdeConTamanio(5,4)
		
	}
	
	override method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == 15
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
	
	override method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == 20
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
	
	override method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == 25
	}
}


object nivelActual {
	
	var property nivel = nivelUno
	
	method estado() {
		if (nivel.seGanoNivel()) {self.estadoDelJuego()}
	}
	
	method estadoDelJuego() {
		if (self.quedanNiveles()) {self.pasarDeNivel()}
		 else {self.victory()}
	}
	
	method pasarDeNivel() {
		self.nivelSiguiente()
		heroe.reiniciarPosicion()
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
	
}