import config.*
import random.*
import elementos.*
import tanque.*
import wollok.game.*
import escenarios.*

class Enemigo inherits Tanque {

	var timeMove
	var shotTime
	
	method moverDisparandoAleatorio(){		
		game.onTick(timeMove,  "MOVER_ENEMIGO" + self.identity(), {self.avanzar()})
		game.onTick(shotTime,  "DISPARAR_ENEMIGO" + self.identity(), {config.movimientoDe(self.nuevaBala())})			
	}

	method avanzar(){
		direccion = self.proximaDireccion();

	 	if(self.validaPosicion(direccion.siguientePosicion(position)) and self.sinObstaculo(direccion.siguientePosicion(position))) {
        	position = direccion.siguientePosicion(position)
		} 
	}
	
	method proximaDireccion() {
		if(self.heroeEsObjetivo()) {
			return self.ubicarHeroe()	
		} else {
			return random.direccionAleatoria();	
		}
	}
	
	method ubicarHeroe() {
		const posicionHeroe = heroe.position();
		if(self.position().x() > posicionHeroe.x()) return izquierda
		else if(self.position().x() < posicionHeroe.x()) return derecha
		else if(self.position().y() > posicionHeroe.y()) return abajo
		else return arriba
	}
	
	method heroeEsObjetivo() {
		const heroePosition = heroe.position();
		
		return heroePosition.x() == self.position().x() or heroePosition.y() == self.position().y();
	}

	method moverAl(_direccion){
		return {_direccion.siguientePosicion(self.position())}
	}
	
	method removerEnemigo(){
		game.removeTickEvent("DISPARAR_ENEMIGO"+ self.identity())
		game.removeTickEvent("MOVER_ENEMIGO"+ self.identity())
		gestorDeEnemigos.removerElemento(self)
	}
	
	override method recibirDanio(bala) {
		if (self.esDisparoDelDefensor(bala)) {super(bala)}
	}
	
	method esDisparoDelDefensor(bala) {
		return bala.tanque() == heroe
	}
	
	override method destruido(){
		self.removerEnemigo()
		nivelActual.estado()
	}
	
	method modelo()
	
}

class Leopard inherits Enemigo{

	override method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
	override method modelo(){
		return "Leopard II"
	}
}

class MBT70 inherits Enemigo{

	override method image() {
		return "MBT-70_" + direccion.sufijo()  + ".png"
	}
	
	override method modelo(){
		return "MBT70"
	}
	
	override method nuevaBala(){
		return new Fireball(tanque = self, direccion = direccion, position = position)
	}
}


class T62 inherits Enemigo{

	override method image() {
		return "T-62_" + direccion.sufijo()  + ".png"
	}
	
	override method modelo(){
		return "T62"
	}
	
	override method nuevaBala(){
		return new Plasma(tanque = self, direccion = direccion, position = position)
	}
}



//DE LA RAMA REFACTOR CON AYUDIN MODIFICADO

//Pensar mecanismo para aumentar dificultad por nivel
// Se me ocurre que llegue por parametro el nivel, y hacer algun calculo
// Por ejemplo en el nivel 3 hacer => 3 * 5 y eso sumarle al danio de los disparos o a la velocidad de movimiento



object factoryLeopard {
	method generarEnemigo() {
		return new Leopard(direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 10, shotTime = 3000, timeMove = 4000);
	}
}

object factoryMBT70 {
	method generarEnemigo() {
		return new MBT70 (direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 5, shotTime = 2500, timeMove = 3000);
	}
}

object factoryT62 {
	method generarEnemigo() {
		return new T62 (direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 15, shotTime = 2500, timeMove = 3000);
	}
}


object gestorDeEnemigos{ 
	
	var property enemigosEnMapa = []
	var property enemigosAgregados = 0
	var property enemigosCaidos = 0 
	
	const factories = [factoryLeopard, factoryMBT70, factoryT62];


	method agregarEnemigos() {
		if (self.faltanAgregarEnemigos()){
			self.agregarNuevoEnemigo()
			game.say(defensa,"¡CUIDADO! Se acerca un " + enemigosEnMapa.last().modelo() + ".")
			enemigosAgregados += 1
		}		
	}
	
	method faltanAgregarEnemigos() { 
		return enemigosAgregados < nivelActual.enemigosADestruirPorNivel()
			   and 
			   enemigosEnMapa.size() <= 3
	}
	
	method agregarNuevoEnemigo(){
		const nuevoEnemigo = factories.anyOne().generarEnemigo()
		nuevoEnemigo.moverDisparandoAleatorio() 
		self.agregarElemento(nuevoEnemigo)
	}
	
	method agregarElemento(enemigo){
		enemigosEnMapa.add(enemigo)	 
		game.addVisual(enemigo)
	}
	
	method removerElemento(enemigo) {
		game.removeVisual(enemigo)
		enemigosEnMapa.remove(enemigo)
		enemigosCaidos += 1
	}
	
	method resetEnemigos() {
		enemigosEnMapa = []
		enemigosAgregados = 0
		enemigosCaidos = 0
	}
}