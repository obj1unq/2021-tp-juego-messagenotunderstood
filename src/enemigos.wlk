import config.*
import random.*
import elementos.*
import random.*
import tanque.*
import wollok.game.*

class Leopard inherits Tanque{

	var timeMove
	var shotTime

	override method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
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
	
	method modelo(){
		return "Leopard II"
	}
}