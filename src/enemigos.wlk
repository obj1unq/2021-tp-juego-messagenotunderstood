import config.*
import random.*
import elementos.*
import tanque.*
import wollok.game.*
import escenarios.*

class Enemigo inherits Tanque{

	var timeMove
	var shotTime
	
	method moverDisparandoAleatorio(){		
		game.onTick(timeMove,  "MOVER_ENEMIGO" + self.identity(), {self.avanzar()})
		game.onTick(shotTime,  "DISPARAR_ENEMIGO" + self.identity(), {config.movimientoDe(self.balaDisparada())})			
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
		
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	override method impactar(bala){
//		game.say(self, "Vida:" + self.vida().toString()) // msg para testear la cantidad de vida que quita.
		if (self.validaVida()){
			self.recibirDanio(bala)	
		} else {
			bala.explotar()
			self.removerEnemigo()
			nivelActual.estado()
		}
	}
	
	method removerEnemigo(){
		game.removeTickEvent("DISPARAR_ENEMIGO"+ self.identity())
		game.removeTickEvent("MOVER_ENEMIGO"+ self.identity())
		gestorDeEnemigos.removerElemento(self)
	}
	
	method removerElemento(){
		game.removeVisual(self)
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
	
	override method balaDisparada(){
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
	
	override method balaDisparada(){
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
