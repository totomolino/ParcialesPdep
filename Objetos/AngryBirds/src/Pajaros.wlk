class Pajaro {
	
	var property ira

	method fuerza(){
		return ira * 2
	}
	
	method enojarse(){
		ira *= 2
	}
	
	method fuerzaMayorA(numero){
		return self.fuerza() > numero 
		
	}
	
	method tranquilizarse(){
		ira -= 5
	}
	
	method enojarseXVeces(numero){
		numero.times({self.enojarse()})
	}
	
	method puedeDerribarObstaculo(obstaculo){
		return self.fuerza() > obstaculo.resistencia()
	}

	
	

}


class PajaroRencoroso inherits Pajaro{
	
	var property multiplicador
	
	var cantVecesEnojado = 0
	
	override method fuerza() {
		return ira * multiplicador * cantVecesEnojado
	} 
	
	override method enojarse(){
		cantVecesEnojado += 1
		super()
	}
	
	
}




class Red inherits PajaroRencoroso {
	
	override method fuerza() {
		return ira * 10 * cantVecesEnojado
	} 			
}



class Bomb inherits Pajaro {
	
	const fuerzaMaxima = 9000
	
	override method fuerza(){
			return super().min(fuerzaMaxima)
	}	
}



class Chuck inherits Pajaro {
	
	var property velocidad 
	
	override method fuerza(){
		if(velocidad <= 80){
			return 150
		}
		return 5 * (velocidad - 80)
	}
	
	override method enojarse() {
		velocidad *= 2
		super()
	}
	
	override method tranquilizarse(){}
	
	
}

class Terence inherits PajaroRencoroso {
	
}


class Matilda inherits Pajaro {
	
	var huevos

	
	override method fuerza() {
		return 2 * (huevos.sum({huevo => huevo.peso()}))
	}
	
	override method enojarse(){
		huevos.add(new Huevo(peso = 2))
		super()
	}
	
}

class Huevo {
	
	const property peso
}







	
	
	