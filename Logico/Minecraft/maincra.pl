jugador(stuart, [piedra, piedra, piedra, piedra, piedra, piedra, piedra, piedra], 3).
jugador(tim, [madera, madera, madera, madera, madera, pan, carbon, carbon, carbon, pollo, pollo], 8).
jugador(steve, [madera, carbon, carbon, diamante, panceta, panceta, panceta], 2).

lugar(playa, [stuart, tim], 2).
lugar(mina, [steve], 8).
lugar(bosque, [], 6).

comestible(pan).
comestible(panceta).
comestible(pollo).
comestible(pescado).

%1)

tieneItem(Jugador,Item):-
  jugador(Jugador,Items,_),
 member(Item,Items).
 
 %tieneItem(Jugador,Item):-
  % jugador(Jugador,Items,_),
   %setof(I,member(I,Items),L),
   %member(Item,L).
   
sePreocupaPorSuSalud(Jugador):-
  tieneItem(Jugador,Item),
  tieneItem(Jugador,OtroItem),
  comestible(Item),
  comestible(OtroItem),
  Item\=OtroItem.
  
cantidadDelItem(Jugador,Item,Cantidad):-
  tieneItem(_,Item),
  jugador(Jugador,_,_),
  findall(Item,tieneItem(Jugador,Item),Items),
  length(Items,Cantidad).
 
  
 
tieneMasDe(Jugador,Item):-
  cantidadDelItem(Jugador,Item,Cantidad),
  findall(C,cantidadDelItem(_,Item,C),Cantidades),
  forall(member(C,Cantidades),C=<Cantidad).

  
%2)

hayMonstruos(Lugar):-
  lugar(Lugar,_,Oscuridad),
  Oscuridad > 6.

correPeligro(Jugador):-
  lugar(Lugar,Personajes,_),
  hayMonstruos(Lugar),
  member(Jugador,Personajes).

correPeligro(Jugador):-
  estaHambriento(Jugador),
 forall(tieneItem(Jugador,Item),not(comestible(Item))).

  
  
estaHambriento(Jugador):-
  jugador(Jugador,_,Hambre),
  Hambre < 4.  
 
estaPoblado(Lugar):-
  lugar(Lugar,Poblacion,_),
  length(Poblacion,C),
  C>0.

nivelDePeligrosidad(Lugar,Nivel):-
  lugar(Lugar,_,Nivel),
  not(estaPoblado(Lugar)).
  
nivelDePeligrosidad(Lugar,Nivel):-
  estaPoblado(Lugar),
  algunNombre(Lugar,Nivel).

%Usar algun nombre mas expresivo   
algunNombre(Lugar,Nivel):-
  not(hayMonstruos(Lugar)),
  lugar(Lugar,Poblacion,_),
  length(Poblacion,Total),
  findall(H,(member(H,Poblacion),estaHambriento(H)),Hambrientos),
  length(Hambrientos,C),
  Nivel is C*100/Total.

algunNombre(Lugar,100):-
  hayMonstruos(Lugar).

  
item(horno, [ itemSimple(piedra, 8) ]).
item(placaDeMadera, [ itemSimple(madera, 1) ]).
item(palo, [ itemCompuesto(placaDeMadera) ]).
item(antorcha, [ itemCompuesto(palo), itemSimple(carbon, 1) ]).


tieneLoNecesario(Jugador,itemSimple(Item,Cantidad)):-
  cantidadDelItem(Jugador,Item,C),
  C >= Cantidad.
  
tieneLoNecesario(Jugador,itemCompuesto(Item)):-
  jugador(Jugador,_,_),
  item(Item,ItemsNecesarios),
  forall(member(I,ItemsNecesarios),tieneLoNecesario(Jugador,I)).
  
puedeConstruir(Jugador,Item):-
  jugador(Jugador,_,_),
  item(Item,Requisitos),
  forall(member(Requisito,Requisitos),tieneLoNecesario(Jugador,Requisito)).
  
%Claramente estoy repitiendo lógica, si alguien quiere modificarlo, bienvenido sea.
