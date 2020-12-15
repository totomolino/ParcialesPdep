%% magos %%


%%%%%%%%%%%%%%%
%%  Parte 1  %%
%%%%%%%%%%%%%%%





%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

casa(gryffindor).
casa(slytherin).
casa(ravenclaw).
casa(hufflepuff).

sangre(harry,mestiza).
sangre(draco, pura).
sangre(hermione, impura).
sangre(neville, pura).
sangre(luna, pura).
sangre(ron, pura).

mago(Mago) :- sangre(Mago, _).

% permiteEntrar(Casa, Mago)

permiteEntrar(Casa, Mago):- 
    casa(Casa),
    mago(Mago),
    Casa \= slytherin.

permiteEntrar(slytherin, Mago):- 
    sangre(Mago, Sangre),
    Sangre \= impura.


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

caracterRequerido(gryffindor, coraje).
caracterRequerido(slytherin, orgullo).
caracterRequerido(slytherin, inteligencia).
caracterRequerido(ravenclaw, inteligencia).
caracterRequerido(ravenclaw, responsabilidad).
caracterRequerido(hufflepuff, amistad).


tieneCaracteristica(harry, coraje).
tieneCaracteristica(harry, amistad).
tieneCaracteristica(harry, orgullo).
tieneCaracteristica(harry, inteligencia).
tieneCaracteristica(draco, inteligencia).
tieneCaracteristica(draco, orgullo).
tieneCaracteristica(hermione, orgullo).
tieneCaracteristica(hermione, inteligencia).
tieneCaracteristica(hermione, responsabilidad).
tieneCaracteristica(neville, responsabilidad).
tieneCaracteristica(neville, coraje).
tieneCaracteristica(neville, amistad).


tieneCaracterApropiado(Mago, Casa):-
    casa(Casa),
    mago(Mago),
    forall(caracterRequerido(Casa,CaracterRequerido),tieneCaracteristica(Mago, CaracterRequerido)).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

odiaIr(harry, slytherin).
odiaIr(draco, hufflepuff).

puedeQuedarEn(Mago, Casa):-
    tieneCaracterApropiado(Mago,Casa),
    permiteEntrar(Casa, Mago),
    not(odiaIr(Mago,Casa)).

puedeQuedarEn(hermione, gryffindor).


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


cadenaDeAmistades(Magos):-
    todosAmistosos(Magos),
    cadenaDeCasas(Magos).


todosAmistosos(Magos):-
    forall(member(Mago, Magos) , tieneCaracteristica(Mago, amistad)).

cadenaDeCasas([Mago1, Mago2 | MagosSiguientes]):-
    puedeQuedarEn(Mago1, Casa),
    puedeQuedarEn(Mago2, Casa),
    cadenaDeCasas([Mago2 | MagosSiguientes]).

cadenaDeCasas([_]).
cadenaDeCasas([]).



%%%%%%%%%%%%%%%
%%  Parte 2  %%
%%%%%%%%%%%%%%%




%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

hizoAccion(harry, fueraDeLaCama).
hizoAccion(hermione, irA(tercerPiso)).
hizoAccion(hermione, irA(seccionRestringida)).
hizoAccion(harry, irA(tercerPiso)).
hizoAccion(harry, irA(bosque)).
hizoAccion(draco, irA(mazmorras)).
hizoAccion(draco, irA(tercerPiso)).
hizoAccion(ron, buenaAccion(50, ganarPartida)).
hizoAccion(hermione, buenaAccion(50, salvarAmigos)).
hizoAccion(harry, buenaAccion(60, ganarleAVoldemort)).
hizoAccion(cedric, buenaAccion(100, ganarleAVoldemort)).
hizoAccion(hermione, responderPregunta(comoLevitarUnaPluma, 25 , flitwick)).
hizoAccion(hermione, responderPregunta(dondeSeEncuentraUnBezoar, 20 , snape)).

lugarProhibido(tercerPiso, 75).
lugarProhibido(bosque, 50).
lugarProhibido(seccionRestringida, 10).

esBuenAlumno(Mago):-
    hizoAlgunaAccion(Mago),
    not(hizoAlgoMalo(Mago)).


hizoAlgunaAccion(Mago):-
    hizoAccion(Mago,_).

hizoAlgoMalo(Mago):-
    hizoAccion(Mago,Accion),
    puntajeQueGenera(Accion, Puntaje),
    Puntaje < 0 .


puntajeQueGenera(fueraDeLaCama, -50).

puntajeQueGenera(irA(Lugar), Puntaje):-
    lugarProhibido(Lugar, Puntos),
    Puntaje is Puntos * -1.




puntajeQueGenera(buenaAccion(Puntaje, _) , Puntaje).


puntajeQueGenera(responderPregunta(_, Puntos, snape) , PuntajeFinal):- 
    PuntajeFinal is Puntos // 2.

puntajeQueGenera(responderPregunta(_, Puntos, Profesor) , Puntos):- Profesor \= snape.



esAccionRecurrente(Accion):-
    hizoAccion(Mago1, Accion),
    hizoAccion(Mago2, Accion),
    Mago1 \= Mago2.


%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


esDe(hermione, gryffindor).
esDe(ron, gryffindor).
esDe(harry, gryffindor).
esDe(draco, slytherin).
esDe(luna, ravenclaw).
esDe(cedric, hufflepuff).



puntajeDeCasa(Casa, PuntajeTotal):-
    casa(Casa),
    findall(Puntos, (esDe(Mago,Casa) , puntosQueObtuvo(Mago, _ , Puntos)) , ListaPuntos),
    sum_list(ListaPuntos, PuntajeTotal).


puntosQueObtuvo(Mago, Accion, Puntos):-
    hizoAccion(Mago,Accion), 
    puntajeQueGenera(Accion, Puntos).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%



casaGanadora(Casa):-
    puntajeDeCasa(Casa, UnPuntaje),
    forall((puntajeDeCasa(OtraCasa, OtroPuntaje) , Casa \= OtraCasa) , UnPuntaje > OtroPuntaje).



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

