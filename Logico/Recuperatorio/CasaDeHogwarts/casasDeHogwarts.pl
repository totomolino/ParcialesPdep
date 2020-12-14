%% magos %%








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