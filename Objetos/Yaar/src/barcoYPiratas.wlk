import misiones.*


class Barco {
	
	var property tripulantes = []
	
	var property mision
	
	const capacidad 
	
	method tieneLugar(){
		return self.cantTripulantes() < capacidad
	}
	
	method cantTripulantes(){
		return tripulantes.size()
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
	 
	method echarInutiles(unaMision){
		tripulantes.removeAllSuchThat({pirata => not pirata.esUtil(unaMision)})
	}
	
	method pirataMasEbrio(){
		return tripulantes.max({pirata => pirata.ebriedad()})
	}
	
	method puedeHacerMision(){return (mision.sirveBarco(self)) && self.tieneSuficienteTripulacion()}
	
	method tieneSuficienteTripulacion(){
		return ((capacidad * 90) / 100) <= self.cantTripulantes()
	}
	
	method algunoTieneItem(item){
		return tripulantes.any({pirata => pirata.tieneItem(item)})
	}
	
	method esVulnerableA(barco){
		return (barco.cantTripulantes() / 2) >= self.cantTripulantes() 
	}
	
	method todosPasados(){
		return tripulantes.all({pirata => pirata.estaPasado()})
	}
	
	method anclarACiudad(ciudad){
		tripulantes.forEach({pirata => pirata.anclarACiudad()})
		self.sacarAlMasEbrio()
		ciudad.aumentarHabitantes(1)
		}
	
	method sacarAlMasEbrio(){
		tripulantes.remove(self.pirataMasEbrio())
	}
	
	method esTemible(){
		return self.puedeHacerMision()
	}
	
	method vulnerabilidad(pirata){
		return pirata.estaPasado()
	}
	
	method cuantosEstanPasados(){
		return tripulantes.size({pirata => pirata.estaPasado()})
	}
	
	method cuantosTiposDeItems(){
		return self.todosLosItemsSinRepetir().size()
	}
	
	method todosLosItemsSinRepetir() {
		return (tripulantes.map({pirata => pirata.items()})).flatten().asSet()
	}
	
	method elMasEbrioYRico(){
		return tripulantes.max({pirata => pirata.ebriedad() && pirata.cantDinero()})
	}
	
}


class Pirata {
	
	var property items = [" "]
	
	var property ebriedad = 0
	
	var property cantDinero = 0
	
	method esUtil(mision){
		return mision.sirveElPirata(self)		
		
	}
	
	method estaPasado(){
		return self.alMenosXEbriedad(90)
	}
	
	method tieneItems(itemsRequeridos){
		return itemsRequeridos.any{item => self.tieneItem(item)}
	}
	
	method tieneItem(unItem){
		return items.any({item => unItem == item})
	}
	
	method itemsMasDe(numero){
		
		return items.size() >= numero
		
	}
	
	method seAnimaAAtacar(objetivo){
		return objetivo.vulnerabilidad(self)
		
	}
	
	method alMenosXEbriedad(numero){
		return numero <= ebriedad
	}
	
	method puedeEntrarAlBarco(barco){
		return barco.tieneLugar() && self.esUtil(barco.mision())
	}
	
	method tomarUnTrago(){
		ebriedad += 5
	}
	 
	method gastarDinero(numero){
		if(numero <= cantDinero){
			cantDinero -= numero
		}
		self.error("Te quedaste corto pa")
	}
	
	method anclarACiudad(){
		self.tomarUnTrago()
		self.gastarDinero(1)
	}
	
}

class PirataEspia inherits Pirata {
	
	override method ebriedad(nuevaEbriedad){
		ebriedad = nuevaEbriedad.min(89)
	}
	
	override method tomarUnTrago(){
		ebriedad = (ebriedad + 5).min(89)
	}
	
	
	override method seAnimaAAtacar(objetivo){
		return (objetivo.vulnerabilidad(self)) && (self.tieneItem("permiso"))
	}
	
	
	
}










