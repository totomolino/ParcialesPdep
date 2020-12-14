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


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

permiteEntrar(Mago, slytherin) :-
    mago(Mago, _,_),
    not(mago(Mago, impura, _)).

permiteEntrar(Mago, Casa) :-
    casa(Casa),
    Casa \= slytherin,
    mago(Mago, _, _).



%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


tieneCaracter(Mago, Casa) :-
    mago(Mago, _, CaracterDelMago),
    casa(Casa),
    forall(caracteriza(Casa, Caracter),member(Caracter,CaracterDelMago)).
  


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

casaPosible(Mago, Casa) :-
    mago(Mago,_,_),
    casa(Casa),
    permiteEntrar(Mago, Casa),
    tieneCaracter(Mago, Casa),
    not(odia(Mago, Casa)).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


cadenaDeAmistades(Magos) :-
    todesAmigues(Magos),
    mismaCasaTodes(Magos).

mismaCasaTodes([PrimerMago, SegundoMago]) :-
    casaPosible(PrimerMago, Casa),
    casaPosible(SegundoMago, Casa).

mismaCasaTodes([PrimerMago, SegundoMago | LosOtros]) :-
    casaPosible(PrimerMago, Casa),
    casaPosible(SegundoMago, Casa),
    mismaCasaTodes([SegundoMago|LosOtros]).

    

todesAmigues(Magos) :-
    forall(member(Mago, Magos), tieneAmistad(Mago)).

tieneAmistad(Mago):-
    mago(Mago, _, Caracter),
    member(amistad, Caracter).



%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%
    

lugarProhibido(bosque,50).
lugarProhibido(seccionRestringida,10).
lugarProhibido(tercerPiso,75).

alumnoFavorito(flitwick, hermione).
alumnoFavorito(snape, draco).
alumnoOdiado(snape, harry).

hizo(ron, buenaAccion(jugarAlAjedrez, 50)).
hizo(harry, fueraDeCama).
hizo(hermione, irA(tercerPiso)).
hizo(harry, responder('Donde se encuentra un Bezoar', 15, snape)).
hizo(hermione, responder('Donde se encuentra un Bezoar', 15, snape)).
hizo(hermione, responder('Wingardium Leviosa', 25, flitwick)).
hizo(ron, irA(bosque)).
hizo(draco, irA(mazmorras)).

% hizo(hermione, responder(dondeSeEncuentraUnBezoar, 15, snape)).
% hizo(hermione, responder(wingardiumLeviosa, 25, flitwick)).

esDe(harry, gryffindor).
esDe(ron, gryffindor).
esDe(hermione, gryffindor).


esBuenAlumno(Mago) :-
    mago(Mago,_, _),
    forall(hizo(Mago, Accion), not(puntajeNegativo(Accion, _))).

puntajeNegativo(fueraDeCama, -50).
puntajeNegativo(irA(Lugar), Puntos) :-
    lugarProhibido(Lugar, PuntosPos),
    Puntos is PuntosPos * -1.




%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%


% puntajeAlumno(Alumno, PuntajeAlumno) :-
%     mago(Alumno, _, _),
%     puntosPregunta(Alumno, PuntajeProfe),
%     puntosMalasAcciones(Alumno, PuntajeNegativo),
%     puntosBuenaAccion(Alumno, PuntajeBuenaAccion),
%     PuntajeAlumno is PuntajeProfe + PuntajeBuenaAccion + PuntajeNegativo.


% puntosMalasAcciones(Alumno, Puntaje) :-
%     mago(Alumno, _, Accion),
%     puntajeNegativo(Accion, Puntaje).

% puntosPregunta(Alumno, PuntajeFinal) :-
%     hizo(Alumno, responder(_, PuntosPregunta, Profesor)),
%     findall(Puntos, puntosSegunProfe(Alumno, Profesor, PuntosPregunta, Puntos), PuntosProfe),
%     sumlist(PuntosProfe, PuntajeFinal).

% puntosSegunProfe(Alumno, Profesor, PuntosPregunta, Puntos):-
%     alumnoFavorito(Profesor, Alumno),
%     Puntos is PuntosPregunta * 2.

% puntosSegunProfe(Alumno, Profesor, _ , 0):-
%     alumnoOdiado(Profesor, Alumno).

% puntosSegunProfe(Alumno, Profesor, Puntos, Puntos) :-
%     not(alumnoFavorito(Profesor, Alumno)),
%     not(alumnoOdiado(Profesor, Alumno)).

% puntosBuenaAccion(Alumno, Puntaje) :-
%     mago(Alumno, _, _),
%     hizo(Alumno, buenaAccion(_,Puntaje)).


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



%%%%%%%%%%%%%
%% Punto 7 %%
%%%%%%%%%%%%%

puntajeFinal(gryffindor, 482).
puntajeFinal(slytherin, 472).
puntajeFinal(ravenclaw, 426).
puntajeFinal(hufflepuff, 352).


 %sin listas

casaGanadora(Casa) :-
    esDe(_,Casa),
    forall(esDe(_,OtraCasa) , supera(Casa, OtraCasa)).


supera(Casa, OtraCasa) :-
    puntajeFinal(Casa, PuntajeMayor),
    puntajeFinal(OtraCasa, PuntajeMenor),
    PuntajeMayor >= PuntajeMenor.


% con listas

casaGanadora2(Casa) :-
    puntajeFinal(Casa, PuntajeNashe),
    findall(Puntos, puntajeFinal(_,Puntos), Puntajes),
    max_member(PuntajeNashe, Puntajes).
    
