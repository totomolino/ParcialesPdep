mago(harry, mestiza, [coraje, amistad, orgullo, inteligencia]).
mago(ron, pura, [amistad, diversion, coraje]).
mago(hermione, impura, [inteligencia, coraje, responsabilidad, amistad, orgullo]).
mago(hannahAbbott, mestiza, [amistad, diversion]).
mago(draco, pura, [inteligencia, orgullo]).
mago(lunaLovegood, mestiza, [inteligencia, responsabilidad, amistad, coraje]).

odia(harry,slytherin).
odia(draco,hufflepuff).

casa(gryffindor).
casa(hufflepuff).
casa(ravenclaw).
casa(slytherin).

caracteriza(gryffindor,amistad).
caracteriza(gryffindor,coraje).
caracteriza(slytherin,orgullo).
caracteriza(slytherin,inteligencia).
caracteriza(ravenclaw,inteligencia).
caracteriza(ravenclaw,responsabilidad).
caracteriza(hufflepuff,amistad).
caracteriza(hufflepuff,diversion).

lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).

alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(hermione, responder("Donde se encuentra un Bezoar", 15, snape)).
hizo(hermione, responder("Wingardium Leviosa", 25, flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).

esDe(harry,gryffindor).
esDe(ron,gryffindor).
esDe(hermione,gryffindor).

%------------------------------------1

permiteEntrar(Casa,Mago):-
	casa(Casa),
	mago(Mago,_,_),
	Casa \= slytherin.

permiteEntrar(slytherin,Mago):-
	mago(Mago,Sangre,_),
	Sangre \= impura.
%------------------------------------2

tieneCaracter(Mago,Casa):-
	casa(Casa),
	mago(Mago,_,Lista),
	forall(caracteriza(Casa,Caracteristicas), member(Caracteristicas,Lista)).

%------------------------------------3

casaPosible(Mago,Casa):-
	tieneCaracter(Mago,Casa),
	permiteEntrar(Casa,Mago),
	not(odia(Mago,Casa)).

%------------------------------------4

cadenaDeAmistades(Lista):-
	forall(member(Mago,Lista), (mago(Mago,_,Caracteristicas), member(amistad,Caracteristicas))),
	mismaCasa(Lista).

mismaCasa([_|[]]).

mismaCasa([Mago,OtroMago|Magos]):-
  casaPosible(Mago,Casa1),
  casaPosible(OtroMago,Casa1),
  mismaCasa([OtroMago|Magos]).
 
%------------------------------------5

esBuenAlumno(Alumno):-
	hizo(Alumno,_),
	forall(hizo(Alumno,CosaQueHizo), not(malaAccion(CosaQueHizo))).
	
malaAccion(fueraDeCama).
malaAccion(irA(Lugar)):-
	lugarProhibido(Lugar,_).
	
%------------------------------------6

puntosDeCasa(Casa,PuntajePOSTA100REALNOFAKE):-
	esDe(_,Casa),
	findall(PuntajeTotal,puntosDeCasaDeUnAlumno(Casa,PuntajeTotal),Lista),
	sumlist(Lista,PuntajePOSTA100REALNOFAKE).

puntosDeCasaDeUnAlumno(Casa,PuntajeTotal):-
	esDe(Alumno,Casa),
	hizo(Alumno,Accion),
	findall(PuntajeParcial,puntaje(Alumno,Accion,PuntajeParcial),Lista),
	sumlist(Lista,PuntajeTotal).

puntaje(Alumno, responder(_,Dificultad,Profe), PuntajeParcial):-
	alumnoFavorito(Profe, Alumno),
	PuntajeParcial is Dificultad * 2.

puntaje(Alumno,responder(_,Dificultad,Profe), PuntajeParcial):-
	not(alumnoFavorito(Profe, Alumno)),
	PuntajeParcial is Dificultad.

puntaje(_,fueraDeCama,-50).
puntaje(_,irA(Lugar),PuntajeParcial):-
	lugarProhibido(Lugar,Puntos),
	PuntajeParcial is Puntos * (-1).
	
puntaje(_,buenaAccion(_,Puntos),Puntos).
	
%------------------------------------7
puntosTotales(gryffindor,482).
puntosTotales(slytherin, 472).
puntosTotales(ravenclaw,426).
puntosTotales(hufflepuff,352).

casaGanadora(Casa):-
	puntosTotales(Casa,PuntosDeLaCasaEnCuestion),
	findall(Puntos,puntosTotales(_,Puntos),Lista),
	max_member(PuntosDeLaCasaEnCuestion,Lista).
	
