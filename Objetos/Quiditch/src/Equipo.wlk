import Jugador.*

import Escobas.*


class Equipo {
	
	const integrantes = []
	
	method habilidadPromedio() {
		
		return (integrantes.sum({jugador => jugador.habilidad()})) / (integrantes.size())
		
	}
	
	
	
}