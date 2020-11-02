import Arboles.*

class Presente{
	const property precio
	
	const property destinatario
	
	
}



class Regalo inherits Presente{
	
	const property ocupaEspacio = true
	
	const precioPromedio
	
	method esRegaloTkm(){
		return precio > precioPromedio
	}
	
	
}


class Tarjetas inherits Presente {
	
	const property valorAdjunto
	
	const property ocupaEspacio = false
	
	
	override method precio(){ return 2}
	
	
}


class Adorno {
	
	const property pesoBase
	
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

class Guirnaldas inherits Adorno {
	
	const cuandoSeCompro
	
	const aniosEnUso = new Date() - cuandoSeCompro
	
	override method pesoBase(){
		return super() - (100 * aniosEnUso)
	}
	
	
	
	
}













