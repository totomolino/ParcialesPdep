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
    caracterCasa(Casa, CaracterCasa),
    forall( member(CaracterDeCasa,CaracterCasa),member(CaracterDeCasa,CaracterDelMago)).


caracterCasa(Casa, CaracterCasa):-
    casa(Casa),
    findall(Caracter, caracteriza(Casa, Caracter) , CaracterCasa).


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
    hizo(Mago, Accion),
    esMalaAccion(Accion).

esMalaAccion(fueraDeCama).
esMalaAccion(irA(Lugar)) :-
    esLugarPeligroso(Lugar).


esLugarPeligroso(tercerPiso).
esLugarPeligroso(bosque).
esLugarPeligroso(tercerPiso).

