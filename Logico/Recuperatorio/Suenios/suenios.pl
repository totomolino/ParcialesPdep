

%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


% creencias

creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).
creeEn(juan, conejoDePascua).
creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).


% tipos de suenios

% sueniaCon(gabriel, suenio(ganarLoteria , [5,9])).
% sueniaCon(gabriel, suenio(serFutbolista, arsenal)).
% sueniaCon(juan , suenio(serCantante, 100000)).
% sueniaCon(macarena, suenio(serCantante, 10000)).

sueniaCon(gabriel, ganarLoteria([5,9])).
sueniaCon(gabriel, serFutbolista(arsenal)).
sueniaCon(juan , serCantante(100000)).
sueniaCon(macarena, serCantante(10000)).




%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


esAmbiciosa(Persona):-
    sueniaCon(Persona, _),
    findall(DificultadSuenio , dificultades(Persona, DificultadSuenio) , ListaDeDificultades),
    sum_list(ListaDeDificultades , NivelTotalDeDificultad),
    NivelTotalDeDificultad > 20 .


dificultades(Persona, Dificultad):-
    sueniaCon(Persona, Suenio),
    dificultad(Suenio, Dificultad).


dificultad(serCantante(Discos), 6):-
    Discos > 500000.

dificultad(serCantante(Discos), 4):-
    Discos =< 500000.

dificultad(ganarLoteria(Lista), Dificultad):-
    length(Lista, CuantosNumeros),
    Dificultad is 10 * CuantosNumeros.


dificultad(serFutbolista(Equipo) , 3):- esEquipoChico(Equipo).
dificultad(serFutbolista(Equipo) , 16):- not(esEquipoChico(Equipo)).


esEquipoChico(arsenal).
esEquipoChico(aldosivi).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

tieneQuimica(Personaje , Persona):-
    creeEn(Persona, Personaje),
    cumpleRequerimiento(Persona, Personaje).


cumpleRequerimiento(Persona , campanita):-
    creeEn(Persona, campanita),
    sueniaCon(Persona, Suenio),
    dificultad(Suenio, Dificultad),
    Dificultad < 5.


cumpleRequerimiento(Persona, Personaje):-
    Personaje \= campanita,
    not(esAmbiciosa(Persona)),
    todosSueniosPuros(Persona).

todosSueniosPuros(Persona):-
    not((sueniaCon(Persona, Suenio) , not(esPuro(Suenio)))).


esPuro(serFutbolista(_)).
esPuro(serCantante(Discos)):- Discos < 200000.



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%


esAmigo(campanita, reyesMagos).
esAmigo(campanita, conejoDePascua).
esAmigo(conejoDePascua, cavenaghi).



estaEnfermo(campanita).
estaEnfermo(reyesMagos).
estaEnfermo(conejoDePascua).

puedeAlegrar(_, Persona):-
    sueniaCon(Persona, _).

puedeAlegrar(Personaje, Persona):-
    tieneQuimica(Personaje, Persona),
    condicion(Personaje).

condicion(Personaje):-
    not(estaEnfermo(Personaje)).

condicion(Personaje):-
    personajeBackup(Personaje, PersonajeBackup),
    not(estaEnfermo(PersonajeBackup)).


personajeBackup(Personaje, PersonajeBackup):-
    esAmigo(Personaje, PersonajeBackup).

personajeBackup(Personaje, PersonajeBackup):-
    esAmigo(Personaje, OtroPersonaje),
    esAmigo(OtroPersonaje, PersonajeBackup).














