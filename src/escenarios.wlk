import wollok.game.*
import menuSuperior.*
import elementos.*
import tanque.*
import config.*
import enemigos.*
import musica.*

object pantallaInicial {
	
	const property position = game.origin()
	
	method image() = "wollanzer.jpg"
	
	method iniciar() {
		game.clear()
		game.addVisual(self)
		musicaMenu.play()
		keyboard.enter().onPressDo({ nivelUno.iniciar(); musicaMenu.pause() })
	}
}


class Nivel {
	
	method iniciar() {
		self.reset()
		self.paredDefensa()
		self.agregarObjetosIniciales()
		self.configurarTeclasYMecanismos()
		self.mapa()
		self.generarMenuSuperior()
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
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(5, 0, 1)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(6, 1, 7)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(7, 0, 1)
	}
	
	method configurarTeclasYMecanismos(){
		config.configurarTeclas()
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
	
	method pasarNivel() {
		const festejo = game.sound("homero woohoo.mp3")
		reproductor.play(festejo, 1000)
	}
	
	method generarMenuSuperior(){
		game.addVisual(vidaDelHeroe)
		game.addVisual(leyendaEnemigos)
		game.addVisual(contadorEnemigos)
	}
}


object nivelUno inherits Nivel {
	
	override method agregarCharcos() {
//		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(0, 6, 2)
//		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(10, 6, 12)
	}
	
	override method agregarLadrillos() {
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(1, 7, 11)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(11, 7, 11)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(3, 6, 9)
	}
	
	override method agregarPastizales() {
		
	}
	
	override method agregarMetales() {

//		gestorDeElementos.generarColumaDeMetalDesdeConTamanio(10,3)
//		gestorDeElementos.generarFilaMetalDesdeConTamanio(5,4)
	}
	
	override method enemigosADestruir() {
		return 15
	}
	
	override method pasarNivel() {
		super()
		nivelActual.nivel(nivelDos)
		game.schedule(500, {nivelDos.iniciar()})
	}
}

object nivelDos inherits Nivel {
	
	override method agregarCharcos() {
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(0, 6, 2)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 6, 8)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(10, 6, 13)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(0, 7, 2)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 7, 8)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(10, 7, 13)
	}
	
	override method agregarLadrillos() {
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(2, 10, 4)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(8, 10, 10)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(0, 2, 2)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(10, 2, 13)
	}
	
	override method agregarMetales() {
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(3, 11, 11)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(9, 11, 11)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(6, 3, 3)
		
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	override method enemigosADestruir() {
		return 18
	}
	
	override method pasarNivel() {
		super()
		nivelActual.nivel(ultimoNivel)
		game.schedule(500, {ultimoNivel.iniciar()})
	}
}


object ultimoNivel inherits Nivel{
	
	override method agregarCharcos() {
	 	gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 7, 8)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 6, 8)

	}
	
	override method agregarLadrillos() {
		
	}
	
	override method agregarPastizales() {
		//definir posiciones para pastos
	}
	
	override method agregarMetales() {
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(4, 6, 6)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(8, 6, 6)
		gestorDeElementos.filaDeMetalAPartirDe_Y_hasta_(4, 8, 8)
		gestorDeElementos.filaDeMetalAPartirDe_Y_hasta_(4, 5, 8)
		
		gestorDeElementos.filaDeMetalAPartirDe_Y_hasta_(2, 4, 5)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(2, 6, 4)
		gestorDeElementos.filaDeMetalAPartirDe_Y_hasta_(7, 9, 10)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(10, 7, 8)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(4, 6, 6)
		gestorDeElementos.columnaDeMetalAPartirDe_Y_hasta_(8, 6, 6)
		
	}
	
	override method enemigosADestruir() {
		return 21
	}
	
	override method pasarNivel() {
		super()
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
		game.schedule(3000, {pantallaInicial.iniciar()}) //Provisional
	}
	
	method enemigosADestruirPorNivel() {
		return nivel.enemigosADestruir()
	}
	
}