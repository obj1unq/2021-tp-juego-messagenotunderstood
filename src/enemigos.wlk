import config.*
import random.*
import elementos.*
import random.*
import wollok.game.*

class EnemigoLeopard {
	
	var property vida = 100
	var property position = game.at(10,10)
	var property direccion = izquierda
	const danioDisparo = 15
	var timeMove
	var shotTime

	method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
	method moverDisparandoAleatorio(){		

		game.onTick(timeMove,  "MOVER_ENEMIGO" + self.identity(), {self.avanzar()})
		game.onTick(shotTime,  "DISPARAR_ENEMIGO" + self.identity(), {config.movimientoDe(self.balaDisparada())})			

	}
	method balaDisparada(){
		return new Bala(danio = danioDisparo , direccion = direccion, tanqueActual = self, position = position)
	}

	method avanzar(){
		direccion = random.direccionAleatoria()
	 	if(self.validaPosicion(direccion.siguientePosicion(position)) and self.sinObstaculo(direccion.siguientePosicion(position))) {
                position = direccion.siguientePosicion(position)
		} 
	}
	
	method sinObstaculo(_position){
		return game.getObjectsIn(_position).isEmpty()
	}
	

	method moverAl(_direccion){
		return {_direccion.siguientePosicion(self.position())}
	}
		
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	method impactar(bala){
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
	
	method validaVida(){
		return vida > 0
	}
	
	method modelo(){
		return "Leopard II"
	}
}