import barcoYPiratas.*

class Mision {
	
}



object busquedaDelTesoro{
	
	const itemsRequeridos = ["brujula" , "mapa" , "botella de grogXD"]
	
	const llave = "llave de cofre"
	
	method sirveElPirata(pirata){
		return pirata.tieneItems(itemsRequeridos) && (pirata.cantDinero() <= 5)
	}
	
	method sirveBarco(barco){
		return barco.algunoTieneItem(llave)
	}
	
	
	
}

class ConvertirseEnLeyenda{
	
	const itemObligatorio
	
	method sirveElPirata(pirata){
		return pirata.itemsMasDe(10) && pirata.tieneItem(itemObligatorio)
	}
	
	method sirveBarco(barco){
		return true
	}
	
	
}

class Saqueo{
	
	var dineroMaximo 
	
	var objetivo
	
	method sirveElPirata(pirata){
		return (pirata.cantDinero() < dineroMaximo) && (pirata.seAnimaAAtacar(objetivo))
	}
	
	method sirveBarco(barco){
		return objetivo.esVulnerableA(barco)
	}
	
}