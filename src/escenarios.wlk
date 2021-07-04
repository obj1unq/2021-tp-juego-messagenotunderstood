import wollok.game.*
import menuSuperior.*
import elementos.*
import tanque.*
import config.*
import enemigos.*
import musica.*

class Pantalla {
	
	method image()
	
	method iniciar() {
		game.clear()
		game.addVisualIn(self, game.origin())
	}
}

object pantallaInicial inherits Pantalla{
	
	override method image() = "wollanzer.jpg"
	
	override method iniciar() {
		super()
		reproductor.playMusicaMenu()
		keyboard.enter().onPressDo({nivelUno.iniciar()})
	}
}

object nivelSuperado inherits Pantalla {
	
	override method image() = "NivelSuperado.jpg"
	
	override method iniciar() {
		super()
		reproductor.playNivelSuperado()
	}
}

object gameOver inherits Pantalla {
	
	override method image() = "GameOver.jpg"
	
	override method iniciar() {
		super()
		reproductor.playGameOver()
		keyboard.any().onPressDo({pantallaInicial.iniciar()})
	}
}

class Nivel inherits Pantalla {
	
	override method iniciar() {
		super()
		game.schedule(2000, {
			self.reset()
			self.paredDefensa()
			self.agregarObjetosIniciales()
			self.configurarTeclasYMecanismos()
			self.mapa()
			self.generarMenuSuperior()
		})
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
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(7, 0, 1)
		game.addVisual(new Ladrillo(position = game.at(6,1)))
	}
	
	method configurarTeclasYMecanismos(){
		config.configurarTeclas()
		config.configurarMovimientosYDisparosAleatoriosEnemigos()
	}
	
	method mapa() {
		self.agregarCharcos()
		self.agregarLadrillos()
		self.agregarMetales()
	}
	
	method agregarCharcos() 
	
	method agregarLadrillos() 

	method agregarMetales()
	
	method enemigosADestruir()
	
	method seGanoNivel() {
		return gestorDeEnemigos.enemigosCaidos() == self.enemigosADestruir()
	}
	
	method pasarNivel() {
		nivelSuperado.iniciar()
	}
	
	method generarMenuSuperior(){
		game.addVisual(vidaDelHeroe)
		game.addVisual(leyendaEnemigos)
		game.addVisual(contadorEnemigos)
	}
}


object nivelUno inherits Nivel {
	
	override method image() = "Nivel1.jpg"
	
	override method agregarCharcos() {
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(1, 4, 3)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(1, 5, 4)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(9, 4, 11)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(9, 5, 11)
	}
	
	override method agregarLadrillos() {
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(2, 7, 11)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(10, 7, 11)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(4, 4, 5)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(8, 4, 5)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(2, 1, 2)
		gestorDeElementos.columnaDeLadrilloAPartirDe_Y_hasta_(10, 1, 2)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(5, 4, 7)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(1, 6, 4)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(8, 6, 11)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(0, 3, 4)
		gestorDeElementos.filaDeLadrilloAPartirDe_Y_hasta_(8, 3, 12)
	}
	
	override method agregarMetales() {
		game.addVisual(new Metal(position = game.at(4,9)))
		game.addVisual(new Metal(position = game.at(8,9)))
		game.addVisual(new Metal(position = game.at(6,7)))
	}
	
	override method enemigosADestruir() {
		return 14
	}
	
	override method pasarNivel() {
		super()
		game.schedule(8000, {
			nivelActual.nivel(nivelDos)
			nivelDos.iniciar()
		})	
	}
}

object nivelDos inherits Nivel {
	
	override method image() = "Nivel2.jpg"
	
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
	
	override method enemigosADestruir() {
		return 17
	}
	
	override method pasarNivel() {
		super()
		game.schedule(8000, {
			nivelActual.nivel(ultimoNivel)
			ultimoNivel.iniciar()
		})	
	}
}


object ultimoNivel inherits Nivel{
	
	override method image() = "Nivel3.jpg"
	
	override method agregarCharcos() {
	 	gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 7, 8)
		gestorDeElementos.filaDeAguaAPartirDe_Y_hasta_(4, 6, 8)

	}
	
	override method agregarLadrillos() {
		
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
//		super() pendiente hacer pantalla de Winner para mostrar
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
		if (nivel.seGanoNivel()) {
			reproductor.playFestejo()
			game.schedule(1100, {nivel.pasarNivel()})
		}
	}
	
	method reStartSiPuede() { 
		if (heroe.leQuedanVidas()) {
			nivel.iniciar()
		} else 
			{gameOver.iniciar()}
	}
	
	method enemigosADestruirPorNivel() {
		return nivel.enemigosADestruir()
	}
	
}