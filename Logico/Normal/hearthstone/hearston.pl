
nombre(jugador(Nombre,_,_,_,_,_), Nombre).
nombre(criatura(Nombre,_,_,_), Nombre).
nombre(hechizo(Nombre,_,_), Nombre).

vida(jugador(_,Vida,_,_,_,_), Vida).
vida(criatura(_,_,Vida,_), Vida).
vida(hechizo(_,curar(Vida),_), Vida).

danio(criatura(_,Danio,_), Danio).
danio(hechizo(_,danio(Danio),_), Danio).

mana(jugador(_,_,Mana,_,_,_), Mana).
mana(criatura(_,_,_,Mana), Mana).
mana(hechizo(_,_,Mana), Mana).

cartasMazo(jugador(_,_,_,Cartas,_,_), Cartas).
cartasMano(jugador(_,_,_,_,Cartas,_), Cartas).
cartasCampo(jugador(_,_,_,_,_,Cartas), Cartas).

jugador(jugador(_,_,_,_,_,_)).

carta(criatura(_,_,_,_)).
carta(hechizo(_,_,_)).

%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

tieneCarta(Jugador, Carta) :-
    cartas(Jugador, Cartas),
    member(Carta,Cartas).


cartas(Jugador,Cartas) :-
    cartasMazo(Jugador,Cartas).

cartas(Jugador,Cartas) :-
    cartasMano(Jugador,Cartas).

cartas(Jugador,Cartas) :-
    cartasCampo(Jugador,Cartas).

%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

esGuerrero(Jugador) :-
    cartas(Jugador,_),
    forall(tieneCarta(Jugador, Carta) , esCriatura(Carta) ).
    
esCriatura(criatura(_,_,_,_)).
    

%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

finalDeTurno(JugadorAntes, JugadorDespues) :-
    cartasMano(JugadorAntes,CartasMano),
    cartasMazo(JugadorAntes,CartasMazo),
    nth1(1,CartasMazo,PrimerCarta),
    append(CartasMano, [PrimerCarta] , ManoNueva),
    cartas(JugadorDespues, ManoNueva),
    ganarMana(1,JugadorAntes, JugadorDespues).

ganarMana(Num,JugadorAntes ,  jugador(_,_,ManaNueva,_,_,_)) :-
    mana(JugadorAntes, Mana),
    ManaNueva is Mana + Num.


%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

% a

puedeJugarCarta(Jugador, Carta) :-
    jugador(Jugador),
    carta(Carta),
    mana(Jugador,ManaJugador),
    mana(Carta,ManaCarta),
    ManaJugador >= ManaCarta.

% b

cualesPuedoJugar(Jugador, Cartas) :-
    jugador(Jugador),
    cartas(Jugador, Cartas),
    findall(Carta, puedeJugarCartaSiguienteTurno(Jugador, Carta) , Cartas).

puedeJugarCartaSiguienteTurno(Jugador, Carta) :-
    finalDeTurno(Jugador, JugadorDespues),
    estaEnMano(JugadorDespues, Carta),
    puedeJugarCarta(JugadorDespues, Carta).





estaEnMano(Jugador, Carta) :-
    cartasMano(Jugador, Cartas),
    member(Carta,Cartas).


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%

%todasLasJugadaProximas(Jugador).


%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%

cartaMasDanina(Jugador, NombreCarta) :-
    jugador(Jugador),
    cartas(Jugador, Cartas),
    forall(member(Carta,Cartas) , not(supera(Carta, CartaFuerte))),
    nombre(CartaFuerte, NombreCarta).


supera(Carta, CartaFuerte) :-
    danio(Carta, DanioCarta),
    danio(CartaFuerte, DanioFuerte),
    DanioCarta > DanioFuerte.


%%%%%%%%%%%%%
%% Punto 7 %%
%%%%%%%%%%%%%

% a)

jugarContra(Carta, JugadorAntes, JugadorDespues) :-
    esHechizoDanio(Carta),
    danio(Carta, Danio),
    vida(JugadorAntes, VidaPrevia),
    vida(JugadorDespues, VidaPosterior),
    VidaPosterior is VidaPrevia - Danio.
    



esHechizoDanio(hechizo(_,danio(_),_)).