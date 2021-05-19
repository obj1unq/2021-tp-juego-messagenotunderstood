import tanque.*
import wollok.game.*
import elementos.*
import enemigos.*

object config {

	method configurarTeclas() {
		keyboard.a().onPressDo({ tanque.irA(tanque.position().left(1), "izquierda")})
		keyboard.d().onPressDo({ tanque.irA(tanque.position().right(1), "derecha")})
		keyboard.w().onPressDo({ tanque.irA(tanque.position().up(1), "arriba")})
		keyboard.s().onPressDo({ tanque.irA(tanque.position().down(1), "abajo")})
		keyboard.space().onPressDo({ tanque.disparar() })
	}
	
	method configurarColisiones(){
		//TODO: implementar colisiones con los obstaculos aca??
		//const bala = new Bala(direccion = "arriba")
		//game.onTick(1, "DISPARO" + bala.identity(), {bala.desplazar()})
		
	}
	

	method configurarMovimientosYDisparosAleatoriosEnemigos(){
		game.onTick(5000, "TANQUESENEMIGOS", {gestorDeEnemigos.agregarEnemigos()})

	}
}