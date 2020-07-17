% jugador(Jugador,Equipo): relaciona cada jugador 
% con su equipo

jugador(heaton,nip).	%nip = Ninjas in Pijamas
jugador(potti,nip).
jugador(element,gol).	%gol = Game OnLine

% equipoTerrorista y equipoAntiTerrorista: 
% en qué bando está cada equipo

equipoTerrorista(nip).
equipoAntiTerrorista(gol).

/* Equipamiento de cada jugador, usando estos functores
       casco(resistencia,ventilacion)
       chaleco(resistencia)
       rifle(modelo,velocidad en disparos por segundo)
       pistola(modelo,velocidad)
 */

equipamiento(heaton,casco(20,9)).
equipamiento(heaton,chaleco(80)).
equipamiento(heaton,rifle(ak47,30)).
equipamiento(heaton,pistola(usp,12)).
equipamiento(heaton,pistola(desertEagle,25)).

equipamiento(potti,pistola(desertEagle,25)).
equipamiento(potti,rifle(awp,25)).
equipamiento(potti,rifle(galil,60)).
equipamiento(potti,casco(20,9)).
equipamiento(potti,chaleco(80)).

equipamiento(element,pistola(desertEagle,25)).
equipamiento(element,rifle(awp,25)).
equipamiento(element,rifle(galil,60)).
equipamiento(element,rifle(galil,60)).
equipamiento(element,rifle(galil,60)).
equipamiento(element,casco(20,9)).
equipamiento(element,chaleco(80)).

% importanciaRifles: lista de rifles en orden de importancia 
% (el primero es el mas importante)

importanciaRifles([awp,ak47,m4a1,aug,galil,famas]).

% presentoA(EquipoPresentador, EquipoPresentado)
% para entrar al servidor te tiene que presentar otro equipo

presentoA(nip,gol).
presentoA(mTw,nip).
presentoA(mTw,noA).
presentoA(noA,fip).

% mapas (zonas) limítrofes, 
% como la base es generada, ya los arma en ambos sentidos

limitrofe(dust2,inferno).
limitrofe(inferno,dust2).
limitrofe(dust2,train).
limitrofe(train,dust2).
limitrofe(inferno,cbble).
limitrofe(cbble,inferno).

% en qué mapa está cada jugador ahora
estaEn(heaton,dust2).
estaEn(potti,inferno).
estaEn(element,inferno).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


tienenDk(Equipo) :-
    equipoTerrorista(Equipo),
    forall(jugador(Jugador, Equipo) ,equipamiento(Jugador, pistola(desertEagle, 25))).




%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


% a

resistenciaItem(rifle(_,_), 0).
resistenciaItem(pistola(_,_), 0).
resistenciaItem(chaleco(Resistencia), Resistencia).
resistenciaItem(casco(Resistencia,_), Resistencia).


% b

enemigos(Jugador, Enemigo) :-
    jugador(Jugador, EquipoJugador),
    jugador(Enemigo, EquipoEnemigo),
    EquipoJugador \= EquipoEnemigo,
    otroBando( EquipoJugador, EquipoEnemigo).

otroBando(Equipo1, Equipo2) :-
    equipoAntiTerrorista(Equipo1),
    equipoTerrorista(Equipo2).

otroBando(Equipo1, Equipo2) :-
    equipoAntiTerrorista(Equipo2),
    equipoTerrorista(Equipo1).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%


equipoComplicado(Equipo) :-
    equipoTerrorista(Equipo),
    terroComplicado(Equipo).

equipoComplicado(Equipo) :-
    equipoAntiTerrorista(Equipo),
    ctComplicado(Equipo).

terroComplicado(Equipo):-
    jugador(_, Equipo),
    forall(jugador(Jugador, Equipo), not(equipamiento(Jugador, rifle(awp,_)))).

terroComplicado(Equipo):-
    jugador(Jugador, Equipo),
    not(equipamiento(Jugador, casco(_,_))),
    not(equipamiento(Jugador, chaleco(_))).

ctComplicado(Equipo) :-
    equipoAntiTerrorista(Equipo),
    forall(jugador(Jugador, Equipo) , not(tieneRifleGroso(Jugador))).

ctComplicado(Equipo) :-
    jugador(JugadorConCasco,Equipo),
    findall(JugadorConCasco, equipamiento(JugadorConCasco, casco(_,_)) , JugadoresConCasco),
    length(JugadoresConCasco, CuantosConCasco),
    CuantosConCasco < 5 .


tieneRifleGroso(Jugador) :-
    equipamiento(Jugador, Rifle),
    esRifleGroso(Rifle).

esRifleGroso(rifle(Rifle,_)) :-
    importanciaRifles(ListaArmas),
    nth1(PosM4, ListaArmas, m4a1),
    nth1(PosRifle, ListaArmas, Rifle),
    PosRifle =< PosM4.

esRifleGroso(rifle(_,Cadencia)) :-
    equipamiento(_, rifle(_,Cadencia)),
    Cadencia >= 50.



%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%



equipoProtegido(Equipo) :-
    jugador(_, Equipo),
    forall(jugador(Jugador, Equipo) , resistenciaTotalMayorA100(Jugador)).


resistenciaTotalMayorA100(Jugador) :-
    resistenciaDeJugador(Jugador, Resistencia),
    Resistencia >= 100.

resistenciaDeJugador(Jugador, ResistenciaJugador) :-
    equipamiento(Jugador, _),
    findall(Resistencia, (resistenciaItem(Item, Resistencia) , equipamiento(Jugador, Item)) , ListaDeResistencia),
    sum_list(ListaDeResistencia, ResistenciaJugador).
    


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%    


regionLlena(Mapa) :-
    mapaLleno(Mapa),
    forall(limitrofe(Mapa,MapaLimitrofe) , mapaLleno(MapaLimitrofe)).

mapaLleno(Mapa) :-
    itemsMapa(Mapa, CuantosItems),
    CuantosItems >= 12.
    
itemsMapa(Mapa, CuantosItems):-
    estaEn(_, Mapa),
    findall(Item, (estaEn(Jugador, Mapa) , equipamiento(Jugador, Item)) , Items),
    length(Items, CuantosItems).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%    


% no funciona bien pero me canse rey

puedeMoverse(Jugador, Origen, Origen) :-
    estaEn(Jugador, Origen).

puedeMoverse(Jugador, Origen, Destino) :-
    limitrofe(Origen, Destino),
    estaEn(Jugador, Origen),
    cantEnemigos(Destino, Jugador, Cantidad),
    Cantidad =< 3,
    puedeMoverse(Jugador, Destino, Destino).


puedeMoverse(Jugador, Origen, Destino) :-
    limitrofe(Origen, Limitrofe),
    estaEn(Jugador, Origen),
    cantEnemigos(Limitrofe, Jugador, Cantidad),
    Cantidad =< 3,
    puedeMoverse(Jugador, Limitrofe, Destino).

cantEnemigos(Mapa, Jugador, Cantidad) :-
    estaEn(_,Mapa),
    jugador(Jugador,_),
    findall(Enemigo, (estaEn(Mapa,Enemigo) , enemigos(Jugador,Enemigo)) , Enemigos),
    length(Enemigos, Cantidad).



puedeIrA(Jugador, Destino) :-
    estaEn(Jugador, Origen),
    puedeMoverse(Jugador, Origen, Destino).