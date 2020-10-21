import Escobas.*

import Equipo.*


class Jugador {
	
	const peso
	
	var skills 
	
	var escoba 
	
	var property punteria
	
	var property fuerza
	
	var property nivelVision 
	
	var property nivelReflejos
	
	var equipo
	
	
	
	method habilidad()
	
	method nivelDeManejo() {
		return skills / peso
	}
	
	method velocidad() {
		return escoba.velocidad() * self.nivelDeManejo()
	}
	
	
	
	
	method lePasaElTrapoA(otroJugador){
		
		return self.habilidad() >= (2 * otroJugador.habilidad())			
		
	}
	
	method esGroso(){
		return self.masHabilDelEquipo() and self.velocidadMayorA(mercadoDeEscobas.valorArbitrario())
	}
	
	method masHabilDelEquipo() {
		return equipo.habilidadPromedio() < self.habilidad()
	} 
	
	method velocidadMayorA(numero){
		return self.velocidad() > numero
	}

	
}





class Cazador inherits Jugador {
		
	override method habilidad(){		
		return self.velocidad() + skills + (punteria * fuerza)	
	}
	
} 


class Guardianes inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + nivelReflejos + fuerza
	}	
	
}


class Golpeadores inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + punteria + fuerza	
	}
	
}

class Buscadores inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + (nivelReflejos * nivelVision)	
	}
	
}





