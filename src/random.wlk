import wollok.game.*
import elementos.*

object random {	
	method position() {
		return 	game.at( 
					(0 .. game.width() - 1 ).anyOne(), (11)) 
	}
	
	method direccionAleatoria(){				
		return [/*arriba*/ abajo, izquierda, abajo, derecha].anyOne()	
	}
	
	method emptyPosition() {
		const position = self.position()
		if(game.getObjectsIn(position).isEmpty()) {
			return position	
		}
		else {
			return self.emptyPosition()
		}
	}
}
	

