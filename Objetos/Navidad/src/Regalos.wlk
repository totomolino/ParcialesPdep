import Arboles.*

class Presente{
	const property precio
	
	const property destinatario
	
	
}



class Regalo inherits Presente{
	
	const property ocupaEspacio = true
	
	
	
	
}


class Tarjetas inherits Presente {
	
	const property valorAdjunto
	
	const property ocupaEspacio = false
	
	
	override method precio(){ return 2}
	
	
}


class Adorno {
	
	const pesoBase
	
	const superioridad
	
	method importancia(){
		return pesoBase * superioridad
	}
	
	
}


class Luces inherits Adorno {
	
	const cantidadDeLuces 
	
	method luminosidad(){return cantidadDeLuces}
	
	override method importancia(){
		return  self.luminosidad() * super() 
	}
	
}

class FiguraElaboradas inherits Adorno {
	
	const volumen
	
	override method importancia(){
		return volumen * super() 
	}
	
}














