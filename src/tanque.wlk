import wollok.game.*

object tanque {
	//Vida del tanque
	var property health = 100
	var property position = game.origin()
	var ultimoMovimiento = "arriba"
	//El AP puede ir incrementando a medida que se avanza en el juego.
	var attackPower = 20

	method image() {
		if (ultimoMovimiento == "arriba")  
		{  return "tanque_up.png"
			
		} else if (ultimoMovimiento == "abajo"){
			return "tanque_dw.png"
		} else if (ultimoMovimiento == "derecha"){
			return "tanque_rh.png"
		} else {
			return "tanque_lf.png"
		}
	}
	
	method disparar(){
	
	}

	method irA(_position, _direction){
		position = _position
		ultimoMovimiento = _direction
		
	}
	
}

