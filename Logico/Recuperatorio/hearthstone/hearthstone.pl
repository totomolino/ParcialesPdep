% jugadores

% jugador(Nombre, PuntosVida, PuntosMana, CartasMazo, CartasMano, CartasCampo).



% cartas

% criatura(Nombre, PuntosDaño, PuntosVida, CostoMana)

% hechizo(Nombre, FunctorEfecto, CostoMana)

% efectos

% danio(CantidadDaño)
% cura(CantidadCura)

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


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%


% Relacionar un jugador con una carta que tiene. La carta podría estar en su mano, en el campo o en el mazo.


tieneCarta(Jugador, Carta):-
    cartas(Jugador, Cartas),
    member(Carta, Cartas).


cartas(Jugador, Cartas):-
    cartasMazo(Jugador, Cartas).

cartas(Jugador, Cartas):-
    cartasMano(Jugador, Cartas).

cartas(Jugador, Cartas):-
    cartasCampo(Jugador, Cartas).
    
carta(Carta):-
    tieneCarta(_, Carta).

%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

% Saber si un jugador es un guerrero. Es guerrero cuando todas las cartas que tiene, ya sea en el mazo la mano o el campo, son criaturas.

esGuerrero(Jugador):-
    jugador(Jugador),
    forall(tieneCarta(Jugador, Carta) , esCriatura(Carta)).

esCriatura(criatura(_,_,_,_)).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

% Relacionar un jugador consigo mismo después de empezar el turno. Al empezar el turno, la primera carta del mazo pasa a estar en la mano y el jugador gana un punto de maná.

empezarTurno(JugadorAntes, JugadorDespues):-
    cartasMano(JugadorAntes, ManoAnterior),
    cartasMazo(JugadorDespues, [PrimerCarta | NuevoMazo]),
    append([PrimerCarta] , ManoAnterior , NuevaMano),
    cartasMano(JugadorDespues, NuevaMano),
    cartasMazo(JugadorDespues, NuevoMazo),
    ganarMana(JugadorAntes, JugadorDespues, 1).


ganarMana(JugadorAntes, JugadorDespues, Cuanto):-
    mana(JugadorAntes, Mana),
    mana(JugadorDespues, ManaFinal),
    ManaFinal is Mana + Cuanto.

    
    

%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

% a 

puedeJugarCarta(Jugador, Carta):-
%    tieneCarta(Jugador, Carta),
    jugador(Jugador),
    carta(Carta),
    mana(Jugador, Mana),
    mana(Carta, ManaNecesario),
    Mana >= ManaNecesario.


% b 

cualesPuedeJugar(Jugador, Cartas):-
    empezarTurno(Jugador, JugadorDespues),
    findall(Carta, (puedeJugarCarta(JugadorDespues, Carta) , estaEnMano(JugadorDespues, Carta)) , Cartas).

estaEnMano(Jugador, Carta):-
    cartasMano(Jugador, Cartas),
    member(Carta, Cartas).



%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


posiblesJugadas(Jugador, Combinacion):-
    cualesPuedeJugar(Jugador, Cartas),
    empezarTurno(Jugador, JugadorDespues),
    mana(JugadorDespues, Mana),
    combinacionesPosibles(Cartas, Mana, Combinacion).


combinacionesPosibles([] , _ , []).

combinacionesPosibles([Carta | Cartas] , Mana , [Carta | Posibles]):-
    mana(Carta, Costo),
    Mana >= Costo,
    ManaRestante is Mana - Costo,
    combinacionesPosibles(Cartas, ManaRestante, Posibles).

combinacionesPosibles([_ | Cartas] , Mana , Posibles):- combinacionesPosibles(Cartas, Mana, Posibles).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%


% cartaMasDanina(Jugador, NombreDeCarta):-
%     tieneCarta(Jugador, criatura(NombreDeCarta, DanioMaximo, _, _)),
%     not(((tieneCarta(Jugador, criatura(OtroNombre , OtroDanio,_)) , OtroNombre \= NombreDeCarta) , DanioMaximo > OtroDanio )).


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


% a 

jugarContra(Carta, JugadorAntes, JugadorFinal):-
    esHechizoDanio(Carta),
    puedeJugarCarta(JugadorAntes, Carta),
    atacar(Carta, JugadorAntes , JugadorDespues),
    tirarCarta(JugadorDespues, Carta, JugadorFinal).


tirarCarta(Jugador, Carta, JugadorFinal):-
    cartasMano(Jugador, Cartas),
    member(Carta, Cartas),
    nth1(_, )



esHechizoDanio(hechizo(_, danio(_),_)).

atacar(Carta, JugadorAntes, JugadorDespues):-
    danio(Carta, Danio),
    restarVida(JugadorAntes, Danio, JugadorDespues).

restarVida(Jugador, Danio, JugadorDespues):-
    vida(Jugador, Vida),
    vida(JugadorDespues, VidaFinal),
    VidaFinal is Vida - Danio.


% b 

esHechizoCuracion(hechizo(_, curar(_) , _)).

jugar(Carta, JugadorAntes, JugadorDespues):-
    esHechizoCuracion()


