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
		direccion = random.direccionAleatoria()
	 	if(self.validaPosicion(direccion.siguientePosicion(position)) and self.sinObstaculo(direccion.siguientePosicion(position))) {
                position = direccion.siguientePosicion(position)
		} 
	}

	method moverAl(_direccion){
		return {_direccion.siguientePosicion(self.position())}
	}
	
	method removerEnemigo(){
		game.removeTickEvent("DISPARAR_ENEMIGO"+ self.identity())
		game.removeTickEvent("MOVER_ENEMIGO"+ self.identity())
		gestorDeEnemigos.removerElemento(self)
	}
	
	override method destruido(){
		self.removerEnemigo()
		nivelActual.estado()
	}
	
	method modelo()
	
}


class MBT70 inherits Enemigo{

	override method image() {
		return "MBT-70_" + direccion.sufijo()  + ".png"
	}
	
	override method modelo(){
		return "MBT70"
	}
	
	override method nuevaBala(){
		return new Fireball(direccion = direccion, position = position)
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
		return new Plasma(direccion = direccion, position = position)
	}
}


class Leopard inherits Enemigo{

	override method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
	override method modelo(){
		return "Leopard II"
	}
}



//DE LA RAMA REFACTOR CON AYUDIN MODIFICADO

//Pensar mecanismo para aumentar dificultad por nivel
// Se me ocurre que llegue por parametro el nivel, y hacer algun calculo
// Por ejemplo en el nivel 3 hacer => 3 * 5 y eso sumarle al danio de los disparos o a la velocidad de movimiento



object factoryLeopard {
	method generarEnemigo() {
		return new Leopard(direccion = abajo, position =  random.emptyPosition(), danioDisparo= 20, shotTime = 3000, timeMove = 4000);
	}
}

object factoryMBT70 {
	method generarEnemigo() {
		return new MBT70 (direccion=abajo, position = random.emptyPosition(), danioDisparo= 12, shotTime = 2500, timeMove = 3000);
	}
}

object factoryT62 {
	method generarEnemigo() {
		return new T62 (direccion=abajo, position = random.emptyPosition(), danioDisparo= 25, shotTime = 2500, timeMove = 3000);
	}
}


object gestorDeEnemigos{ 
	
/*Pendiente: mejorar que se dejen de agregar enemigos cuando se alcanza la cantidad de enemigos
			 a destruir por nivel. 
*/
	  
	
	var property enemigosEnMapa = []
	var property enemigosCaidos = 0 
	
	const factories = [factoryLeopard, factoryMBT70, factoryT62];

	method agregarEnemigos() {
		if (self.enemigosEnMapa().size() <= 3 ) {
			self.agregarNuevaEnemigo()
			game.say(defensa,"¡CUIDADO! Se acerca un " + enemigosEnMapa.last().modelo() + ".")
		}		
	}
	
	method agregarNuevaEnemigo(){
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
	
	method resetearEnemigos() {
		enemigosEnMapa = [] //Provisional (no haria falta si de dejar de crear enemigos en cierto número que responda cada nivel)
		enemigosCaidos = 0
	}
}