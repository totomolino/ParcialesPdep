class Pared {
	
	var anchoPared 
	
	var material
	
	method resistencia(){
		return material.resistenciaMaterial() * anchoPared
	}
	
	
}


object vidrio {
	
	const property resistenciaMaterial = 10
	
}

object madera {
	
	const property resistenciaMaterial = 25
	
}

object piedra {
	
	const property resistenciaMaterial = 50
	
}


class Cerdito {
	
	var tipo
	
	method resistencia(){
		return tipo.resistenciaSegunTipo()
	}	
	
	
	
}

object obrero {
	
	const property resistenciaSegunTipo = 50
}


class Armado {
	
	const herramienta
	
	method resistenciaSegunTipo(){
		return 10 * herramienta.resistenciaHerramienta()
	}
	
	
}


class Herramienta {
	
	const property resistenciaHerramienta 
}










