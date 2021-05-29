import config.*
import random.*
import elementos.*
import random.*
import wollok.game.*
import tanque.*

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
	
	method hacerDanio(bala) {
		bala.explotar()
		vida -= bala.danio()
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
	
	override method image() {
		return "leopard_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "Leopard II"
	}
	
	
}


class T62 inherits Enemigo {
	
	//Cambiar valor de vida y danioDisparo al instanciar
	
	override method image() {
		return "T-62_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "T-62"
	}
	
	
}

class MBT70 inherits Enemigo {
	
	//Cambiar valor de vida y danioDisparo al instanciar
	
	override method image() {
		return "MBT-70_" + direccion.sufijo()  + ".png"
	}
	
	method modelo(){
		return "MBT-70"
	}
	
}

