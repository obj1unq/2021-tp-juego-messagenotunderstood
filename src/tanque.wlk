import wollok.game.*
import elementos.*
import config.*

object tanque {
	var property vida = 100
	var property position = game.origin()
	var property ultimoMovimiento = "arriba"
	const danioDisparo = 15

	method image() {
		return if (ultimoMovimiento == "arriba")  "tanque_up.png"
		 else if  (ultimoMovimiento == "abajo")   "tanque_dw.png"
		  else if (ultimoMovimiento == "derecha") "tanque_rh.png"
		   else "tanque_lf.png"	
	}

	method disparar(){
		const bala = new Bala(danho = danioDisparo , direccion = ultimoMovimiento)
		bala.trayecto()
	}

	method irA(_position, _direction){
		if (self.validaPosicion(_position) and self.sinObstaculo(_position)){
			position = _position
			ultimoMovimiento = _direction
		}
	}
	
	method sinObstaculo(_position){
		return game.getObjectsIn(_position).isEmpty()
	}
	
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -1) and _position.x().between(0, game.height() -1))
	}
	
	method impactar(bala){
		if (self.validaVida()){
			bala.explotar()
			vida -= bala.danho()	
		} else {
			game.removeVisual(self)
		}
	}
	
	method validaVida(){
		return vida > 0
	}
}
