import Frutas.*

import Tarea.*


class Empleado {
	
	var property tareasRealizadas = 0
	
	var property dificultadTotal = 0
		
	var property estamina = 0
	
	var rol
	
	
	method aumentarEstamina(valor){
		estamina = estamina + valor
	}
	
	method disminuirEstamina(valor){
		estamina = estamina - valor
	}
	
	method comerFruta(fruta){
		self.aumentarEstamina(fruta.puntosDeEnergia())
	}
	
	method experiencia(){
		return tareasRealizadas * dificultadTotal
	}
	
	method cambiarRol(nuevoRol){
		rol.cambioRol()
		rol = nuevoRol
	}
	
	method puedeArreglar(maquina){
		if(not maquina.requiereHerramientas()){
			return (maquina.complejidad() <= estamina)
		}
		return rol.herramientasSuficientes(maquina)
		}
	
	method arreglarMaquina(maquina){
		
		if(self.puedeArreglar(maquina)){
			self.disminuirEstamina(maquina.complejidad())
			tareasRealizadas += 1
			dificultadTotal += maquina.dificultad()
		}
				
	}
		
		
	}
	
	





class Biclope inherits Empleado {
	
	override method aumentarEstamina(valor){
		estamina = (estamina + valor).min(10)
	}
	
	
}


class Ciclope inherits Empleado {
	
	
	
}


class Soldado {
	
	var practica = 50
	
	var practicaGanada = 0
	
	method usarArma(){
		self.aumentarPractica(2)
	}
	
	method aumentarPractica(numero){
		practica = practica + numero
		practicaGanada = practicaGanada + numero
	}
	
	method cambioRol(){
		practica = practica - practicaGanada
		practicaGanada = 0
	}
	
	
	
}


class Obrero {
	
	var property cinturonDeHerramientas = []
	
	method cambioRol(){	
		cinturonDeHerramientas = []
	}
	
	 method herramientasSuficientes(maquina){
	 	return maquina.herramientasSirven(cinturonDeHerramientas)
	 }
	
	
}


class Mucama {
	method cambioRol(){	}
}





















