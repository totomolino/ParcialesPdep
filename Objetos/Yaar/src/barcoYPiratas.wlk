import misiones.*


class Barco {
	
	var property tripulantes = []
	
	var property mision
	
	const capacidad 
	
	method tieneLugar(){
		return tripulantes.size() < capacidad
	}
	
	method sumarCamarada(pirata){
		
		if(self.admitePirata(pirata)){
			
		tripulantes.add(pirata)
		
		}
	}
	
	method admitePirata(pirata){
		return pirata.puedeEntrarAlBarco(self)
	}
	
	method cambiarMision(nuevaMision){
		mision = nuevaMision
		self.echarInutiles(nuevaMision)
	}
	 `
	method echarInutiles(unaMision){
		tripulantes.removeAllSuchThat({pirata => not pirata.esUtil(unaMision)})
	}
	
}


class Pirata {
	
	var property items = []
	
	var property ebriedad
	
	var property cantDinero
	
	method esUtil(mision){
		return mision.sirveElPirata(self)		
		
	}
	
	method tieneItems(itemsRequeridos){
		return itemsRequeridos.any{item => self.tieneItem(item)}
	}
	
	method tieneItem(item){
		return items.contains(item)
	}
	
	method itemsMasDe(numero){
		
		return items.size() >= numero
		
	}
	
	method seAnimaAAtacar(objetivo){
		return objetivo.ebriedadRequerida() <= ebriedad 
	}
	
	method puedeEntrarAlBarco(barco){
		return barco.tieneLugar() && self.esUtil(barco.mision())
	}
	
	
}










