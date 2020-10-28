import Armas.*


class Famiglia {
	
	var don
	
	var integrantes
	
	
	method todaLaFamilia(){return integrantes.add(don)}
	
	method elMasPicante(){
		return (self.todaLaFamilia().filter({persona => persona.estaVivo()})).max({persona => persona.cantDeArmas()})
	}
	
	method armarATodosCon(arma){
		integrantes.forEach({persona => persona.agregarArma(arma)})
	}
	
	method sePicoElCondado(){
		self.armarATodosCon(new Revolver(cantDeBalas = 6))
	}
	
	method ataqueSorpresa(otraFamilia){
		if(not otraFamilia.todosMuertos()){
		(self.todaLaFamilia()).forEach({miembro => miembro.hacerSuTrabajo(otraFamilia.elMasPicante())})
	}
		}
	
	method todosMuertos(){
		return integrantes.all({persona => persona.estaMuerto()})
	}
	
	method estanDeLuto(){
		self.aumentarLealtadParaTodos(10)
		self.convertirSoldadosAptos()
		
	}
	
	method aumentarLealtadParaTodos(numero){
		integrantes.forEach({persona => persona.aumentarLealtad(numero)})
	}
	
	method convertirSoldadosAptos(){
		integrantes.forEach({persona => persona.convertirseEnSubjefe()})
	}
	
	method cambioDeDon(){
		const masLeal = don.subordinadoMasLeal()
		if(masLeal.sabeDespacharElegantemente()){
			don = masLeal
		}
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
	
	var property lealtad
	
	var armas = rango.armas()
	
	var familia
	
	method morir(){
		estado =  muerto
	}
	
	method herir(){
		estado = herido
	}
	
	method estaVivo(){
		return estado == vivo
	}
	
	method estaMuerto(){
		return estado == muerto
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
	
	method tieneArmaSutil(){
		return armas.any({arma => arma.esSutil()})
	}
	
	method convertirEnSubjefe(){
		if(rango.puedeSerSubjefe()){
			rango = new Subjefe(subordinados = [], armas = armas , armasUsadas = []  )
		}
	}
	
	method aumentarLealtad(numero){
		lealtad = lealtad + ((lealtad * numero) / 100)
	}
	
	method traicionarFamilia(){
		
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
	
	method subordinadoMasLeal(){
		return subordinados.max({persona => persona.lealtad()})
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
	
	method puedeSerSubjefe(){
		return false
	}
	
	
	
}


class Soldado {
	
	var property armas = [escopeta]
	
	method hacerSuTrabajo(victima){
		armas.anyOne({arma => arma.usar(victima)})
	}
	
	method puedeSerSubjefe(){
		return (armas.size() > 5 )
	}
	
	
	
	
	
}












