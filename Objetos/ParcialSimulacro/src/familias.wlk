import Armas.*


class Famiglia {
	
	var don
	
	var integrantes
	
	var todaLaFamilia = integrantes.add(don)
	
	
	method elMasPicante(){
		return (todaLaFamilia.filter({persona => persona.estaVivo()})).max({persona => persona.cantDeArmas()})
	}
	
	method armarATodosCon(arma){
		integrantes.forEach({persona => persona.agregarArma(arma)})
	}
	
	method sePicoElCondado(){
		self.armarATodosCon(new Revolver(cantDeBalas = 6))
	}
	
	
	
	
}




object muerto{
	
}
object vivo{
	
}

object herido{
	
}


class Persona {
	
	var estado = vivo
	
	var rango
	
	const armas = rango.armas()
	
	method morir(){
		estado =  muerto
	}
	
	method herir(){
		estado = herido
	}
	
	method estaVivo(){
		return estado == vivo
	}
	
	method cantDeArmas(){
		return armas.size() 
			}
	
	method hacerSuTrabajo(victima){
		rango.hacerSuTrabajo(victima)
	}
	
	method agregarArma(arma){
		rango.armas().add(arma)
	}
	
	method sabeDespacharElegantemente(){
		return rango.sabeDespachar()
	}
	
	method tieneArma(arma){
		return armas.contains(arma)
	}
	
	
}




class Don {
	
	var property armas
	
	var subordinados
	
	method hacerSuTrabajo(victima){
		const subordinado = subordinados.anyOne()
		2.times({subordinado.hacerSuTrabajo(victima)})
	}
	
	method sabeDespachar(){
		return true
	}
	
	
	
	
	
}

class Subjefe {
	
	var property subordinados
	
	var armasUsadas
	
	var property armas
	
	method hacerSuTrabajo(victima){
		if(not armas.isEmpty()){
			const armaAUsar = armas.anyOne()
			armaAUsar.usar(victima)
			armas.remove(armaAUsar)
			armasUsadas.add(armaAUsar)}
		armas.addAll(armasUsadas)
		armasUsadas.clear()
		self.hacerSuTrabajo(victima)
	}
	
	method sabeDespachar(){
		return subordinados.any({subordinado => subordinado.tieneArmaSutil()})
	}
	
	method tieneArmaSutil(){
		return armas.any({arma => arma.esSutil()})
	}
	
	
}


class Soldado {
	
	var property armas = [escopeta]
	
	method hacerSuTrabajo(victima){
		armas.anyOne({arma => arma.usar(victima)})
	}
	
	method tieneArmaSutil(){
		return armas.any({arma => arma.esSutil()})
	}
	
	
	
}












