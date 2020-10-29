class Persona {
	
	var property posicion
	
	var property elementosCerca
	
	var criterio
	
	var tipo
	
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
	
	method comer(bandeja){
		if(self.decideComer(bandeja)){
			
		}
		
		
	}
	
	method decideComer(bandeja){
		return tipo.leGusta(bandeja)
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


class Bandeja {
	
	const property tieneCarne
	
	const property calorias
	
}



class Vegetariano {
	
	method leGusta(bandeja){
		return not bandeja.tieneCarne()
	}
	
	
}

class Dietetico {
	
	const caloriasSegunOMS = 500
	
	method leGusta(bandeja){
		return bandeja.calorias() < caloriasSegunOMS
	}
	
	
}

class Alternado{
	
	var aceptaComida = true
	
	method leGusta(bandeja){
		aceptaComida = not aceptaComida
		return aceptaComida
	}
	
	
	
}

class Combinado {
	
	const todosLosTipos = [new Alternado(), new Dietetico(), new Vegetariano()]
	
	method leGusta(bandeja){
		return todosLosTipos.all({tipo => tipo.leGusta(bandeja)})
	}
	
}











