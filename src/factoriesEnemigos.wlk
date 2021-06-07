import enemigos.*
import random.*

//Pensar mecanismo para aumentar dificultad por nivel
// Se me ocurre que llegue por parametro el nivel, y hacer algun calculo
// Por ejemplo en el nivel 3 hacer => 3 * 5 y eso sumarle al danio de los disparos o a la velocidad de movimiento
class FactoryEnemigo {
	method generarEnemigo();
}

object factoryLeopard inherits FactoryEnemigo{
	override method generarEnemigo() {
		return new Leopard(  position =  random.emptyPosition(), danioDisparo= 20, shotTime = 3000 , timeMove = 4000);
	}
}

object factoryMBT70 inherits FactoryEnemigo{
	override method generarEnemigo() {
		return new MBT70 (   position =  random.emptyPosition(), danioDisparo= 12, shotTime = 2500,  timeMove = 3000);
	}
}

object factoryT62 inherits FactoryEnemigo{
	override method generarEnemigo() {
		return new T62 (     position =  random.emptyPosition(), danioDisparo= 25, shotTime = 2500,  timeMove = 3000);
	}
}