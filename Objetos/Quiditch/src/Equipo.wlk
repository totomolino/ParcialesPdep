import Jugador.*

import Escobas.*


class Equipo {
	
	const property integrantes = [] 
	
	const property equipoRival
	
	method habilidadPromedio() {
		
		return (integrantes.sum({jugador => jugador.habilidad()})) / (integrantes.size())
		
	}
	
	method tieneJugadorEstrella(){
		return integrantes.any({jugador => jugador.esJugadorEstrella()})
		
	}
	
	method jugarPartidoContra(unEquipo){
		
	}
}

