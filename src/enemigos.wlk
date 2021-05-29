import config.*
import random.*
import elementos.*
import random.*
import tanque.*
import wollok.game.*

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
		game.say(self, "Vida:" + self.vida().toString()) // msg para testear la cantidad de vida que quita.
		if (self.validaVida()){
			self.hacerDanio(bala)	
		} else {
			self.removerEnemigo()
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
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
	}
	

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



