import wollok.game.*
import menuSuperior.*
import elementos.*
import tanque.*
import config.*
import enemigos.*
import musica.*

object pantallaInicial {
	
	const property position = game.origin()
	
	method image() = "wollanzer2.jpg"
	
	method iniciar() {
		game.addVisual(self)
		musicaMenu.iniciar()
		keyboard.enter().onPressDo({ nivelUno.iniciar(); musicaMenu.stop() })
	}
}


class Nivel {
	
	
	method iniciar() {
		self.reset()
		self.paredDefensa()
		self.agregarObjetosIniciales()
		self.configurarTeclasYMecanismos()
		//self.estadoDelNivel()
		self.mapa()
	}
	
	method reset() {
		game.clear()
		heroe.resetValores()
		gestorDeEnemigos.resetEnemigos()
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
	
	method enemigosADestruir()
	
	method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == self.enemigosADestruir()
	}
	
	method pasarNivel() 
	
}


object nivelUno inherits Nivel {
	
	override method agregarCharcos() {

		gestorDeElementos.generarFilaDeAguaDesdeConTamanio(5,2)
		gestorDeElementos.generarColumaDeAguaDesdeConTamanio(9,4)
	}
	override method agregarLadrillos() {

		gestorDeElementos.generarFilaDeLadrillosDesdeConTamanio(10,8)	
		gestorDeElementos.generarColumaDeLadrillosDesdeConTamanio(3,7)	

	}
	
	override method agregarPastizales() {
		
	}
	
	override method agregarMetales() {

		gestorDeElementos.generarColumaDeMetalDesdeConTamanio(10,3)
		gestorDeElementos.generarFilaMetalDesdeConTamanio(5,4)
	}
	
	override method enemigosADestruir() {
		return 5
	}
	
	override method pasarNivel() {
		nivelActual.nivel(nivelDos)
		game.schedule(500, {nivelDos.iniciar()})
	}
}

object nivelDos inherits Nivel {
	
	override method agregarCharcos() {
		//definir posiciones de elementos agua	
	}
	
	override method agregarLadrillos() {
		//definir posiciones para los ladrilos
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		//definir posiciones para los Metales
		
	}
	
	override method enemigosADestruir() {
		return 18
	}
	
	override method pasarNivel() {
		nivelActual.nivel(ultimoNivel)
		game.schedule(500, {ultimoNivel.iniciar()})
	}
}


object ultimoNivel inherits Nivel{
	
	override method agregarCharcos() {
		//definir posiciones de elementos agua	
	}
	
	override method agregarLadrillos() {
		//definir posiciones para los ladrilos
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		//definir posiciones para los Metales
		
	}
	
	override method enemigosADestruir() {
		return 21
	}
	
	override method pasarNivel() {
		self.victory()
	}
	
	method victory() {
		//agregar imagen de victoria y que vuelva a pantalla inicial al apretar cualquier tecla
		game.schedule(2000, {game.stop()}) //Provisional
	}
	
}


object nivelActual {
	
	var property nivel = nivelUno
	
	method estado() {
		if (nivel.seGanoNivel()) {nivel.pasarNivel()}
	}
	
	method reStartSiPuede() { //mejorar con alguna visual y delay
		if (heroe.leQuedanVidas()) {
			nivel.iniciar()
		} else 
			{self.gameOver()}
	}
	
	method gameOver() {
		//agregar imagen de fin del juego y que vuelva a pantalla inicial al apretar cualquier tecla
		game.schedule(2000, {game.stop()}) //Provisional
	}
	
	method enemigosADestruirPorNivel() {
		return nivel.enemigosADestruir()
	}
	
}