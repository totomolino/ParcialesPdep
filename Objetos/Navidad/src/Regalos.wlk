import Arboles.*


class Regalo {
	
	const property precio
	
	const property destinatario
	
}


class Tarjetas {
	
	const precio = 2
	
	const property destinatario
	
	const property valorAdjunto
	
	
}


class Adorno {
	
	const pesoBase
	
	const superioridad
	
	method importancia(){
		return pesoBase * superioridad
	}
	
	
}