% precio(tipo de prenda, tela de la prenda, precio de venta)
% los tipos de tela son: estampado(patron, lista de colores que tiene) o 
% liso(color)
precio(remera, estampado(floreado, [rojo, verde, blanco]), 500).
precio(remera, estampado(rayado, [verde, negro, rojo]), 600).
precio(buzo, liso(azul), 1200).
precio(vestido, liso(negro), 3000).
precio(saquito, liso(blanco), 1500).

paleta(sobria, negro).	
paleta(sobria, azul).  	
paleta(sobria, blanco).        
paleta(sobria, gris).
paleta(alegre, verde).	
paleta(alegre, blanco).  
paleta(alegre, amarillo).
paleta(furiosa, rojo).  
paleta(furiosa, violeta).  
paleta(furiosa, fucsia).

esColor(Color):-paleta(_, Color).

prenda(prenda(Prenda,Tela)):-precio(Prenda,Tela,_).


%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%

% coloresCombinables/2 relaciona dos colores distintos si se encuentran en una misma paleta o si uno de ellos es el negro, que puede combinarse con cualquier otro.

algunoEsNegro(negro, _).
algunoEsNegro(_ , negro).

coloresCombinables(UnColor, OtroColor):-
    esColor(UnColor),
    esColor(OtroColor),
    UnColor \= OtroColor,
    cumpleCondicion(UnColor, OtroColor).

cumpleCondicion(UnColor, OtroColor):-
    estaEnLaMismaPaleta(UnColor, OtroColor).

cumpleCondicion(UnColor, OtroColor):-
    not(estaEnLaMismaPaleta(UnColor, OtroColor)), 
    algunoEsNegro(UnColor, OtroColor).

estaEnLaMismaPaleta(UnColor, OtroColor):-
    paleta(Paleta, UnColor),
    paleta(Paleta, OtroColor).



%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%


% colorinche/1 se cumple para un functor prenda/2 si la tela de la misma es estampada y no tiene dos colores que pertenezcan a una misma paleta.

colorinche(prenda(Prenda, Tela)):-
    prenda(prenda(Prenda, Tela)),
    estampadaConDistintosColores(Tela).

estampadaConDistintosColores(estampado(_,Colores)):-
    member(Color, Colores),
    forall((member(OtroColor, Colores) , Color \= OtroColor) , not(estaEnLaMismaPaleta(Color, OtroColor))).



%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

% colorDeModa/1 se cumple para un color si todas las prendas estampadas a la venta tienen ese color.

colorDeModa(Color):-
    esColor(Color),
    forall(precio(_, estampado(_, Colores) , _) , member(Color, Colores)).

%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

% combinan/2 relaciona dos prendas si sus telas quedan bien juntas, lo cual se cumple si las dos son lisas y los colores son combinables,
% o si una es estampada y la otra lisa y alguno de los colores de la estampa es combinable con el color de la tela lisa. 
% No quedan bien dos telas estampadas juntas.


combinan(UnaPrenda, OtraPrenda):-
    prenda(UnaPrenda),
    prenda(OtraPrenda),
  %  UnaPrenda \= OtraPrenda,
    telaDePrenda(UnaPrenda, UnaTela),
    telaDePrenda(OtraPrenda, OtraTela),
    combinanJuntas(UnaTela, OtraTela).

    

telaDePrenda(prenda(_,Tela) , Tela).


combinanJuntas(liso(UnColor), liso(OtroColor)):-
    coloresCombinables(UnColor, OtroColor).


combinanJuntas(estampado(_, Colores) , liso(UnColor) ):-
    algunColorEsCombinable(UnColor, Colores).

combinanJuntas(liso(UnColor) , estampado(_, Colores) ):-
    algunColorEsCombinable(UnColor, Colores).

algunColorEsCombinable(UnColor, Colores):-
%    esColor(UnColor),
    member(OtroColor , Colores),
%    UnColor \= OtroColor,
    coloresCombinables(UnColor, OtroColor).




%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%


% precioMaximo/2 relaciona un tipo de prenda con su precio máximo de todas las prendas a la venta de ese mismo tipo.

precioMaximo(Prenda, PrecioMaximo):-
    precio(Prenda, _, PrecioMaximo),
    not((precio(Prenda, _, OtroPrecio), OtroPrecio > PrecioMaximo)).



%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%

% conjuntoValido/1 dada una lista de prendas, se considera un conjunto válido si todas las que la componen
% combinan con todas las otras y tiene al menos dos elementos. No se requiere que sea inversible.


conjuntoValido(ListaDePrendas):-
    todasCombinan(ListaDePrendas),
    tieneAlMenos(ListaDePrendas, 2).


tieneAlMenos(UnaLIsta, UnaLongitud):-
    length(UnaLista, Longitud),
    Longitud >= UnaLongitud.
    

todasCombinan(UnaLista):-
    forall((member(UnaPrenda, UnaLista) , member(OtraPrenda, UnaLista) , UnaPrenda \= OtraPrenda) , combinan(UnaPrenda, OtraPrenda)).













