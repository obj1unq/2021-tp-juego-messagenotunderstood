import config.*
import random.*
import elementos.*
import random.*
import wollok.game.*

class Enemigo {
	
	var property position = game.at(10,10)
	var property direccion = izquierda
	var property vida = 100
	const danioDisparo = 15
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
	
	
	method balaDisparada(){
		return new Bala(danio = danioDisparo , direccion = direccion, tanqueActual = self, position = position)
	}
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
	}
	
	method validaVida(){
		return vida > 0
	}
	
	method impactar(bala){
		if (self.validaVida()){
			self.hacerDanio(bala)	
		} else {
			self.removerEnemigo()
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
	
	method removerEnemigo(){
		game.removeTickEvent("DISPARAR_ENEMIGO"+ self.identity())
		game.removeTickEvent("MOVER_ENEMIGO"+ self.identity())
		gestorDeEnemigos.removerElemento(self)
	}
	
	method removerElemento(){
		game.removeVisual(self)
	}
	
}

class Leopard inherits Enemigo {
	
	method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "Leopard II"
	}
	
	
}


class T62 inherits Enemigo {
	
	//Cambiar valor de vida y danioDisparo al instanciar
	
	method image() {
		return "T-62_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "T-62"
	}
	
	
}

class MBT70 inherits Enemigo {
	
	//Cambiar valor de vida y danioDisparo al instanciar
	
	method image() {
		return "MBT-70_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "MBT-70"
	}
	
}

