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

% Punto 1

tieneLaCarta(Jugador,Carta):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    cartasMazo(jugador(Jugador,_,_,Cartas,_,_), Cartas),
    member(Carta,Cartas).

tieneLaCarta(Jugador,Carta):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    cartasMano(jugador(Jugador,_,_,_,Cartas,_), Cartas),
    member(Carta,Cartas).

tieneLaCarta(Jugador,Carta):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    cartasCampo(jugador(Jugador,_,_,_,_,Cartas), Cartas),
    member(Carta,Cartas).

% Punto 2

esGuerrero(Jugador):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    forall(cartasMazo(jugador(Jugador,_,_,Cartas,_,_),Cartas),sonCriaturas(Cartas)).

esGuerrero(Jugador):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    forall(cartasMano(jugador(Jugador,_,_,_,Cartas,_),Cartas),sonCriaturas(Cartas)).

esGuerrero(Jugador):-
    nombre(jugador(Jugador,_,_,_,_,_),Jugador),
    forall(cartasCampo(jugador(Jugador,_,_,_,_,Cartas),Cartas),sonCriaturas(Cartas)).

sonCriaturas(Cartas):-
    forall(member(Carta,Cartas),esCriatura(Carta)).

esCriatura((criatura(Carta,_,_,_),_)).

% Punto 3

siguienteTurno(Jugador,JugadorPostTurno):-
    sonElMismo(Jugador,JugadorPostTurno),
    cartasMazo(jugador(Jugador,_,_,CartasDelMazo,_,_), CartasDelMazo),
    cartasMano(jugador(Jugador,_,_,_,CartasDeLaMano,_), CartasDeLaMano),
    aniadirCartaALaMano(CartasDelMazo,CartasDeLaMano,JugadorPostTurno),
    aniadirMana(JugadorPostTurno).

aniadirCartaALaMano(CartasDelMazo,CartasDeLaMano,JugadorPostTurno):-
    nth1(1,CartasDelMazo,PrimeraCarta),
    eliminarCarta(PrimeraCarta,CartasDelMazo),
    aniadirCarta(PrimeraCarta,CartasDeLaMano),
    cartasMano(jugador(JugadorPostTurno,_,_,_,CartasDeLaMano,_), CartasDeLaMano).

sonElMismo(Jugador,JugadorPostTurno):-
    nombre(jugador(Jugador,_,_,_,_,_), JugadorPostTurno).

aniadirCarta(Carta,[Carta,_]).

aniadirMana(JugadorPostTurno):-
    mana(jugador(JugadorPostTurno,_,Mana,_,_,_), Mana),
    Mana is Mana + 1.
    
eliminarCarta(PrimeraCarta,CartasDelMazo):-
    member(Carta,CartasDelMazo),
    findall(Carta,not(son(PrimeraCarta)),CartasDelMazo).

son(PrimeraCarta).


% Punto 4
% a)

puedeJugarUnaCarta(Jugador,Carta):-
    mana(jugador(Jugador,_,ManaDelJugador,_,_,_), ManaDelJugador),
    manaDeLaCarta(Carta,ManaDeLaCarta),
    ManaDelJugador >= ManaDeLaCarta.

puedeJugarUnaCarta(Jugador,Carta):-
    mana(jugador(Jugador,_,ManaDelJugador,_,_,_), ManaDelJugador),
    manaDeLaCarta(Carta,ManaDeLaCarta),
    ManaDelJugador >= ManaDeLaCarta.

manaDeLaCarta(mana(criatura(_,_,_,ManaDeLaCriatura), ManaDeLaCriatura), ManaDeLaCriatura).
manaDeLaCarta(mana(hechizo(_,_,ManaDelHechizo), ManaDelHechizo),ManaDelHechizo).

% b)

podraJugarLasCartas(Jugador,Cartas):-
    cartasMano(jugador(_,_,_,_,Cartas,_), Cartas),
    forall(member(Carta,Cartas),laPoseeYLaPuedeJugar(Jugador,Carta)).

laPoseeYLaPuedeJugar(Jugador,Carta):-
    tieneLaCarta(Jugador,Carta),
    puedeJugarUnaCarta(Jugador,Carta).


% Punto 5

% posiblesJugadas(Jugador):-
%     mana(jugador(Jugador,_,ManaDelJugador,_,_,_), ManaDelJugador),
%     cartasMano(jugador(Jugador,_,_,_,CartasDeLaMano,_), CartasDeLaMano),
%     member(Carta,CartasDeLaMano),
%     findall(Carta,sePodranJugar(ManaDelJugador,Cartas),CartasPosiblesAJugar).

% sePodranJugar(ManaDelJugador,Cartas):-
    
%     findall()

% Punto 6

cartaMasDanina(Jugador,CartaMasDanina):-
    nombre(jugador(Jugador,_,_,_,_,_), Jugador),
    cartasMazo(jugador(Jugador,_,_,Cartas,_,_), Cartas),
    forall(member(Carta,Cartas),not(supera(Carta,CartaMasDanina))).

supera(Carta,CartaMasDanina):-
    danioDeLaCarta(Carta,DanioDeLaCarta),
    danioDeLaCarta(CartaMasDanina,DanioDeLaCartaMasFuerte),
    DanioDeLaCarta > DanioDeLaCartaMasFuerte.

danioDeLaCarta(danio(criatura(_,Danio,_), Danio), Danio).
danioDeLaCarta(danio(hechizo(_,danio(Danio),_), Danio), Danio).


% Punto 7

jugarContra(CartaPorJugar,JugadorPrevioCarta,JugadorPostCarta):-
    sonElMismo(JugadorPrevioCarta,JugadorPostCarta),
    danio(hechizo(CartaPorJugar,danio(Danio),_), Danio),
    vida(jugador(JugadorPrevioCarta,VidaPreviaACarta,_,_,_,_), VidaPreviaACarta),
    vida(jugador(JugadorPostCarta,VidaPostCarta,_,_,_,_), VidaPostCarta),
    VidaPostCarta is VidaPreviaACarta - Danio.

jugar(CartaJugada,JugadorPrevioCarta,JugadorPostCarta):-
    sonElMismo(JugadorPrevioCarta,JugadorPostCarta),
    cartasMano(jugador(JugadorPrevioCarta,_,_,_,CartasDeLaMano,_), CartasDeLaMano),
    cartasCampo(jugador(JugadorPrevioCarta,_,_,_,_,CartasDelCampo), CartasDelCampo),
    eliminarCarta(CartaJugada,CartasDeLaMano),
    aniadirCarta(CartaJugada,CartasDelCampo).

jugar(CartaJugada,JugadorPrevioCarta,JugadorPostCarta):-
    sonElMismo(JugadorPrevioCarta,JugadorPostCarta),
    cartasMano(jugador(JugadorPrevioCarta,_,_,_,CartasDeLaMano,_), CartasDeLaMano),
    cartasCampo(jugador(JugadorPrevioCarta,_,_,_,_,CartasDelCampo), CartasDelCampo),
    eliminarCarta(CartaJugada,CartasDeLaMano),
    aniadirCarta(CartaJugada,CartasDelCampo),
    esHechizoDeCura(CartaJugada),
    curarVida(CartaJugada,JugadorPostCarta).

esHechizoDeCura(CartaJugada):-
    vida(hechizo(CartaJugada,curar(_),_), _).

    curarVida(CartaJugada,JugadorPostCarta):-
    vida(hechizo(_,curar(CantidadDeVidaQueCura),_), CantidadDeVidaQueCura),
    vida(jugador(JugadorPostCarta,VidaDelJugador,_,_,_,_), VidaDelJugador),
    VidaDelJugador is VidaDelJugador + CantidadDeVidaQueCura.


