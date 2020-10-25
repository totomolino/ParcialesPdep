import barcoYPiratas.*

class Mision {
	
}



object busquedaDelTesoro{
	
	const itemsRequeridos = ["brujula" , "mapa" , "botella de grogXD"]
	
	method sirveElPirata(pirata){
		return pirata.tieneItems(itemsRequeridos) && (pirata.cantDinero() <= 5)
	}
	
}

class ConvertirseEnLeyenda{
	
	const itemObligatorio
	
	method sirveElPirata(pirata){
		return pirata.itemsMasDe(10) && pirata.tieneItem(itemObligatorio)
	}
	
	
}

class saqueo{
	
	var dineroMaximo 
	
	var objetivo
	
	method sirveElPirata(pirata){
		return (pirata.cantDinero() < dineroMaximo) && (pirata.seAnimaAAtacar(objetivo))
	}
	
	
}