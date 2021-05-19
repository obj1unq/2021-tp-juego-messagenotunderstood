import tanque.*
import wollok.game.*
import elementos.*
import enemigos.*

object config {

	method teclas() {
		keyboard.a().onPressDo({ tanque.irA(tanque.position().left(1), "izquierda")})
		keyboard.d().onPressDo({ tanque.irA(tanque.position().right(1), "derecha")})
		keyboard.w().onPressDo({ tanque.irA(tanque.position().up(1), "arriba")})
		keyboard.s().onPressDo({ tanque.irA(tanque.position().down(1), "abajo")})
		keyboard.space().onPressDo({ tanque.disparar() })
	}
	
	method configurarColisiones(){
		//TODO: implementar colisiones con los obstaculos aca??
	}

	method configurarMovimientosYDisparosAleatoriosEnemigos(){
		//TODO: implementar un generador de enemigos aleatorios y a cada enemigo pasarle parametros aleatorios para que tengan distinta velocidad, daño, movimiento.
			game.onTick(300, "TANQUESENEMIGOS", {gestorDeEnemigos.agregarEnemigos()})
	}
}