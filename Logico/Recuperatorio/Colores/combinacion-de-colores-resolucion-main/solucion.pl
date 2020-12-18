% Commit de prueba

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

prenda(prenda(Prenda,Tela)):-precio(Prenda,Tela,_).

% 1) coloresCombinables/2 relaciona dos colores distintos si se encuentran en una misma paleta 
% o si uno de ellos es el negro, que puede combinarse con cualquier otro. 

coloresCombinables(Color, OtroColor) :- esColor(Color), esColor(OtroColor), Color \= OtroColor, cumpleCondicion(Color, OtroColor).
cumpleCondicion(Color, OtroColor) :- estanEnMismaPaleta(Color, OtroColor).
cumpleCondicion(Color, OtroColor) :- not(estanEnMismaPaleta(Color, OtroColor)), algunoEsColorNegro(Color, OtroColor).

algunoEsColorNegro(negro, _).
algunoEsColorNegro(_, negro).

estanEnMismaPaleta(Color, OtroColor) :- paleta(Paleta, Color), paleta(Paleta, OtroColor).
esColor(Color):-paleta(_, Color).

% 2) colorinche/1 se cumple para un functor prenda/2 si la tela de la misma es estampada 
% y no tiene dos colores que pertenezcan a una misma paleta.


colorinche(prenda(Prenda, Tela)) :- prenda(prenda(Prenda, Tela)), estampadaConColoresEnDistintaPaleta(Tela).
estampadaConColoresEnDistintaPaleta(estampado(_, Colores)) :- member(Color, Colores),
    forall((member(OtroColor, Colores), Color \= OtroColor ), not(estanEnMismaPaleta(Color, OtroColor))).


% 3) colorDeModa/1 se cumple para un color si todas las prendas estampadas a la venta tienen ese color.
colorDeModa(Color) :- esColor(Color), forall( precio(_, estampado(_, Colores), _), member(Color, Colores)).

% 4) combinan/2 relaciona dos prendas si sus telas quedan bien juntas, lo cual se cumple si las dos son lisas y 
% los colores son combinables, o si una es estampada y la otra lisa y alguno de los colores de la estampa es 
% combinable con el color de la tela lisa. No quedan bien dos telas estampadas juntas.

% prenda(remera, estampado(rayado, [verde, negro, rojo]))

combinan(prenda(Prenda, Tela), prenda(OtraPrenda, OtraTela)) :- prenda(prenda(Prenda, Tela)), prenda(prenda(OtraPrenda, OtraTela)), 
                                        telasQuedanBien(Tela, OtraTela).
telasQuedanBien(liso(Color), liso(OtroColor)) :- coloresCombinables(Color, OtroColor).
telasQuedanBien(liso(Color), estampado(_, Colores)) :- combinaAlgunColor(Colores, Color).
telasQuedanBien(estampado(_, Colores), liso(Color)) :- combinaAlgunColor(Colores, Color).

combinaAlgunColor(Colores, Color) :- member(OtroColor, Colores), coloresCombinables(Color, OtroColor).

% 5)    precioMaximo/2 relaciona un tipo de prenda con su precio maximo de todas las prendas a la venta de ese mismo tipo.
%    ?- precioMaximo(remera, Precio).
%  Precio = 600. 

precioMaximo(Prenda, PrecioMaximo) :- precio(Prenda, _, PrecioMaximo), not((precio(Prenda, _, OtroPrecio), OtroPrecio > PrecioMaximo)).

% 6)   conjuntoValido/1 dada una lista de prendas, se considera un conjunto válido si todas las que la componen combinan 
% con todas las otras y tiene al menos dos elementos.

conjuntoValido(Prendas) :- hayAlMenosDosPrendas(Prendas), combinanTodas(Prendas).
combinanTodas(Prendas) :- forall((member(Prenda,Prendas),member(OtraPrenda, Prendas), Prenda \= OtraPrenda), combinan(Prenda, OtraPrenda)).
hayAlMenosDosPrendas(Prendas) :- length(Prendas, Size), Size >= 2.