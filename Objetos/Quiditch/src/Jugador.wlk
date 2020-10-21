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
	
	var property tieneQuaffle
	
	
	
	method habilidad()
	
	method nivelDeManejo() {
		return skills / peso
	}
	
	method velocidad() {
		return escoba.velocidad() * self.nivelDeManejo()
	}
	
	
	
	
	method lePasaElTrapoA(otroJugador){
		const habilidadRival = otroJugador.habilidad()
		return (self.habilidad()) >= (2 * habilidadRival)			
		
	}
	
	method esGroso(){
		return self.masHabilDelEquipo() and self.velocidadMayorA(mercadoDeEscobas.valorArbitrario())
	}
	
	method masHabilDelEquipo() {
		return (equipo.habilidadPromedio()) < (self.habilidad())
	} 
	
	method velocidadMayorA(numero){
		return self.velocidad() > numero
	}

	method esJugadorEstrella(){
		const rival = equipo.equipoRival()
		return rival.integrantes().all({jugador => self.lePasaElTrapoA(jugador)})
	}
	
}





class Cazador inherits Jugador {
		
	
		
	override method habilidad(){		
		return self.velocidad() + skills + (punteria * fuerza)	
	}
	
	method evitarBloqueoDe(rival){
		
		return rival.PuedeBloquear()
		
	}
	
	method puedeBloquear(tirador){
		return self.lePasaElTrapoA(tirador)
	}
	
	method esBlancoUtil(){
		return tieneQuaffle
	}
} 


class Guardianes inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + nivelReflejos + fuerza
	}	
	
	method puedeBloquear(){
		const numeros = [1,2,3]
		return numeros.anyOne() == 3
	}
	
	method esBlancoUtil(){
		
	}
	
}


class Golpeadores inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + punteria + fuerza	
	}
	
	method puedeBloquear(){
		return self.esGroso()
	}
}

class Buscadores inherits Jugador {
	
	override method habilidad(){
		return self.velocidad() + skills + (nivelReflejos * nivelVision)	
	}
	
	method puedeBloquear(){}
	
	method esBlancoUtil(){
	
	}
	
}





