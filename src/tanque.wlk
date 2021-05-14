import wollok.game.*
import elementos.*

object tanque {
	//Vida del tanque
	var property health = 100
	var property position = game.origin()
	var property ultimoMovimiento = "arriba"
	const balaDelTanque = bala
	//El AP puede ir incrementando a medida que se avanza en el juego.
	var attackPower = 20

	method image() {
		if (ultimoMovimiento == "arriba"){  
			return "tanque_up.png"
		} else if (ultimoMovimiento == "abajo"){
			return "tanque_dw.png"
		} else if (ultimoMovimiento == "derecha"){
			return "tanque_rh.png"
		} else {
			return "tanque_lf.png"	
		}
	}
	
	method disparar(){	
		balaDelTanque.seDisparo(true)
		//bala.avavanzarBala()
	}

	method irA(_position, _direction){
		if (self.validaPosicion(_position)){
			position = _position
			ultimoMovimiento = _direction
		}
		
	}
	
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
}

