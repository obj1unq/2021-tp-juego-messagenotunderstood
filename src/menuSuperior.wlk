import wollok.game.*
import tanque.*

// 196
// 19
object vidaDelHeroe {
	
	const vidas = 3
	
	const property position = game.at(0,12)
	
	method image(){
		 return self.sufijo() + self.vidaDelHeroe() + ".png"
	}
	
	method sufijo(){
		return "VIDA_"
	}
	
	method vidaDelHeroe(){
		return heroe.vida().div(10).roundUp() 
	}
}

object tanques {
	
	const property position = game.at(11,10)
	
	method image(){
		 return "vida.png" // cambiar imagen por un tanque
	}
}
