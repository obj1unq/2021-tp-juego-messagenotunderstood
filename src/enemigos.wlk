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
	
	override method impactar(bala) {
		if (self.esDisparoDelDefensor(bala)) {super(bala)}
	}
	
	method esDisparoDelDefensor(bala) {
		return bala.tanque() == heroe
	}
	
	override method destruido(){
		self.removerEnemigo()
		nivelActual.estado()
	}
	

	
}

class Leopard inherits Enemigo{

	override method modelo(){
		return "leopard"
	}
}

class MBT70 inherits Enemigo{

	override method modelo(){
		return "MBT-70"
	}
	
	override method nuevaBala(){
		return new Fireball(tanque = self, direccion = direccion, position = position)
	}
}


class T62 inherits Enemigo{

	override method modelo(){
		return "T-62"
	}
	
	override method nuevaBala(){
		return new Plasma(tanque = self, direccion = direccion, position = position)
	}
}


object factoryLeopard {
	method generarEnemigo() {
		return new Leopard(direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 10, shotTime = 3000, timeMove = 3000);
	}
}

object factoryMBT70 {
	method generarEnemigo() {
		return new MBT70 (direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 5, shotTime = 2000, timeMove = 2500);
	}
}

object factoryT62 {
	method generarEnemigo() {
		return new T62 (direccion = abajo, position = random.emptyPosition(), potenciaDisparo = 15, shotTime = 2500, timeMove = 3500);
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
			self.avisoDeDefensa()
			enemigosAgregados += 1
		}		
	}
	
	method faltanAgregarEnemigos() { 
		return not (self.seCompletoLaCantidadDeEnemigosDelNivel() or self.hayMaximoDeEnemigosEnMapa())
	}
	
	method seCompletoLaCantidadDeEnemigosDelNivel() {
		return enemigosAgregados == nivelActual.enemigosADestruirPorNivel()
	}
	
	method hayMaximoDeEnemigosEnMapa() {
		return enemigosEnMapa.size() == 4
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
	
	method avisoDeDefensa(){
		 if (self.validaDefensa()){
			game.say(defensa,"¡CUIDADO! Se acerca un " + enemigosEnMapa.last().modelo() + ".")
		}
	}
	
	method validaDefensa(){
		return game.hasVisual(defensa)
	}
}