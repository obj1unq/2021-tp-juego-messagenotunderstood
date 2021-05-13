import wollok.game.*

object tanque {
	//Vida del tanque
	var property health = 100
	var property position = game.origin()
	//El AP puede ir incrementando a medida que se avanza en el juego.
	var attackPower = 20

	method image() {
		return "tanque.png"
	}
	
	method disparar(){
	
	}

	
	method irA(_position){
		position = _position
	}
	
}

