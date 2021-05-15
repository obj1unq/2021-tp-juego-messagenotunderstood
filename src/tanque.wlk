import wollok.game.*
import elementos.*
import config.*

object tanque {
	var property vida = 100
	var property position = game.origin()
	var property ultimoMovimiento = "arriba"

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
		const bala = new Bala(danho = 14 , direccion = ultimoMovimiento)
		bala.position(position, ultimoMovimiento)	
		bala.trayectoriaDe()
	}

	method irA(_position, _direction){
		if (self.validaPosicion(_position)){
			position = _position
			ultimoMovimiento = _direction
		}
	}
	
	method validaPosicion(_position){
		return (_position.y().between(0,game.width() -3) and _position.x().between(0, game.height() -3))
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
