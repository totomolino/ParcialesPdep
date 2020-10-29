class Persona {
	
	var property posicion
	
	var property elementosCerca
	
	var criterio
	
	var tipo
	
	var comidas
	
	method pedirUnaCosa(unaCosa, unaPersona){
		
		unaPersona.pasarCosaA(unaCosa, self)
		
	}
	
	method pasarCosaA(unaCosa, unaPersona){
		if(self.tieneCerca(unaCosa)){
		criterio.pasarAlgo(self, unaCosa, unaPersona)}
		else self.error("No tiene cerca lo que le pedis")
	}
	
	method tieneCerca(unaCosa){
		return elementosCerca.contains(unaCosa)
	}
	
	method sacarElemento(unElemento){
		elementosCerca.remove(unElemento)
	}
	
	method recibirElemento(unElemento){
		elementosCerca.add(unElemento)
	}
	
	method primerElementoCerca(){
		return elementosCerca.head()
	}
	
	method pasarCosa(unaCosa, otraPersona){
		self.sacarElemento(unaCosa)
		otraPersona.recibirElemento(unaCosa)
	}
	
	method darleTodoA(otraPersona){
		elementosCerca.forEach({elemento => self.pasarCosa(elemento, otraPersona)})
	}
	
	method cambiarPosicionCon(otraPersona){
		const nuevaPosicion = otraPersona.posicion()
		otraPersona.posicion(posicion)
		posicion = nuevaPosicion
	}
	
	method comer(unaComida){
		if(self.decideComer(unaComida)){
			self.registrarMorfi(unaComida)				
		}else self.error("No le gusta la comida")
	}
	
	method registrarMorfi(unaComida){
		comidas.add(unaComida)
	}
	
	method decideComer(unaComida){
		return tipo.leGusta(unaComida)
	}
	
	method estaPipon(){
		return comidas.any({comida => comida.esPesada()})
	}
	
	method laEstaPasandoBien(){
		return self.comioAlgo()
	}
	
	method comioAlgo(){
		return not comidas.isEmpty()
	}
	
	
}

object osky inherits Persona {
	
	override method laEstaPasandoBien(){
		
	}
	
}





object sordo {
	
	
	method pasarAlgo(unaPersona, unaCosa, otraPersona){
		const primerCosa = unaPersona.primerElementoCerca()
		unaPersona.pasarCosa(primerCosa, otraPersona )
	}
	
	
	
}


object pasadorProfesional {
	
	method pasarAlgo(unaPersona, unaCosa, otraPersona){
		unaPersona.darleTodoA(otraPersona)
	}
	
	
	
}


object cambiador {
	
	method pasarAlgo(unaPersona, unaCosa, otraPersona){
		unaPersona.cambiarPosicionCon(otraPersona)
	}
	
}


object normal {

	method pasarAlgo(unaPersona, unaCosa, otraPersona){
		unaPersona.pasarCosa(unaCosa, otraPersona)
	}
}


class Comida {
	
	const property tieneCarne
	
	const property calorias
	
	method esPesada(){
		return calorias > 500
	}
	
}



class Vegetariano {
	
	method leGusta(unaComida){
		return not unaComida.tieneCarne()
	}
	
	
}

class Dietetico {
	
	const caloriasSegunOMS = 500
	
	method leGusta(unaComida){
		return unaComida.calorias() < caloriasSegunOMS
	}
	
	
}

class Alternado{
	
	var aceptaComida = true
	
	method leGusta(unaComida){
		aceptaComida = not aceptaComida
		return aceptaComida
	}
	
	
	
}

class Combinado {
	
	const todosLosTipos = [new Alternado(), new Dietetico(), new Vegetariano()]
	
	method leGusta(unaComida){
		return todosLosTipos.all({tipo => tipo.leGusta(unaComida)})
	}
	
}











