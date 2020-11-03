
class Traje {
	
	method recibirGolpe(portador, otroGuerrero)
	
	method aumentarExp()
	
}


class TrajeComun inherits Traje{
	
	const proteccion
	
	
	override method recibirGolpe(portador, otroGuerrero){
		return proteccion
	} 
	
	override method aumentarExp(){
		return 0
	}
	
	
}


class TrajeDeEntrenamiento inherits Traje{
	
	override method recibirGolpe(portador, otroGuerrero){
		return 0
	}
	
	override method aumentarExp(){
		return bonificadorDeExp.porcentaje()
	}
	
}

object bonificadorDeExp{
	var property porcentaje = 2
}
