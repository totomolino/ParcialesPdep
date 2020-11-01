class Inmueble {
	
	const tamanio
	
	const cantDeAmbientes
	
	var operacion
	
	const property zona 
	
	
	
	
	
}


class Casa inherits Inmueble {
	
	const precio 
	
	method precio() {
		return precio + zona.precio()
	}
	
	
	
}


class Ph inherits Inmueble {
	
	method precio() {
		
		return (14000 * tamanio + zona.precio()).max(500000)
		
	}
	
}


class Departamentos inherits Inmueble {
	
	method precio(){
		return cantDeAmbientes * 350000 + zona.precio()
	}
	
	
}






