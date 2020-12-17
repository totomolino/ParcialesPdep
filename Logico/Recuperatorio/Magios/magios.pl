% futuros magios

persona(bart).
persona(larry).
persona(otto).
persona(marge).

%los magios son functores alMando(nombre, antiguedad), novato(nombre) y elElegido(nombre).


persona(alMando(burns,29)).
persona(alMando(clark,20)).
persona(novato(lenny)).
persona(novato(carl)).
persona(elElegido(homero)).

hijo(homero,abbe).
hijo(bart,homero).
hijo(larry,burns).



salvo(carl,lenny).
salvo(homero,larry).
salvo(otto,burns).




%%%%%%%%%%%%%
%% Punto 1 %%
%%%%%%%%%%%%%



esMagio(Persona) :- 
    estaAlMando(Persona).

esMagio(Persona) :- 
    esNovato(Persona).

esMagio(Persona) :- 
    esElegido(Persona).


aspiranteMagio(Persona):-
    persona(Persona),
    hijo(Persona, Padre),
    esMagio(Padre).

aspiranteMagio(Persona):-
    persona(Persona),
    salvo(Persona, UnMagio),
    esMagio(UnMagio).





%%%%%%%%%%%%%
%% Punto 2 %%
%%%%%%%%%%%%%

estaAlMando(UnMagio):-
    persona(alMando(UnMagio,_)).

esNovato(UnMagio):-
    persona(novato(UnMagio)).

esElegido(UnMagio):-
    persona(elElegido(UnMagio)).
    


puedeDarOrdenes(UnMagio, OtroMagio):-
    esMagio(UnMagio),
    esMagio(OtroMagio),
    mayorNivel(UnMagio, OtroMagio).


mayorNivel(UnMagio, OtroMagio):-
    estaAlMando(UnMagio),
    esNovato(OtroMagio).

mayorNivel(UnMagio, OtroMagio):-
    persona(alMando(UnMagio, UnNivel)),
    persona(alMando(OtroMagio, OtroNivel)),
    UnNivel > OtroNivel.

mayorNivel(UnMagio, _):-
    esElegido(UnMagio).


%%%%%%%%%%%%%
%% Punto 3 %%
%%%%%%%%%%%%%

    

sienteEnvidia(Envidioso, ListaDePersonas):-
    persona(Envidioso),
    findall(Persona , (envidiaA(Envidioso, Persona), Envidioso \= Persona), ListaDePersonas).


envidiaA(UnaPersona, OtraPersona):-
    aspiranteMagio(UnaPersona),
    esMagio(OtraPersona).

envidiaA(UnaPersona, OtraPersona):-
    not(aspiranteMagio(UnaPersona)),
    not(esMagio(UnaPersona)),
    aspiranteMagio(OtraPersona).

envidiaA(UnaPersona, OtraPersona):-
    esNovato(UnaPersona),
    estaAlMando(OtraPersona).




%%%%%%%%%%%%%
%% Punto 4 %%
%%%%%%%%%%%%%

%4) Definir el predicado masEnvidioso/1, permite conocer las personas más envidiosas. ( Nota: definirlo sin usar forall/2).

masEnvidioso(Persona):-
    persona(Persona),
    not(((persona(OtraPersona) , OtraPersona \= Persona) , not(envidiaMas(Persona, OtraPersona)))).
%    forall((persona(OtraPersona) , OtraPersona \= Persona) , envidiaMas(Persona, OtraPersona)).

envidiaMas(UnaPersona, OtraPersona):-
    sienteEnvidia(UnaPersona, UnaLista),
    sienteEnvidia(OtraPersona, OtraLista),
    UnaPersona \= OtraPersona,
    length(UnaLista, UnaCantidad),
    length(OtraLista, OtraCantidad),
    UnaCantidad >= OtraCantidad.
    


%%%%%%%%%%%%%
%% Punto 5 %%
%%%%%%%%%%%%%

%Los beneficios son funtores confort(descripcion), confort(descripcion, caracteristica),
% dispersion(descripcion), economico(descripcion, monto).


gozaBeneficio(carl, confort(sillon)).
gozaBeneficio(lenny, confort(sillon)).
gozaBeneficio(lenny, confort(estacionamiento, techado)).
gozaBeneficio(carl, confort(estacionamiento, libre)).
gozaBeneficio(clark, confort(viajeSinTrafico)).
gozaBeneficio(clark, dispersion(fiestas)).
gozaBeneficio( burns , dispersion(fiestas)).
gozaBeneficio(lenny, economico(descuento, 500)).


soloLoGoza(Persona, Beneficio):-
    gozaBeneficio(Persona, Beneficio),
    not((gozaBeneficio(OtraPersona, Beneficio) , OtraPersona \= Persona)).




%%%%%%%%%%%%%
%% Punto 6 %%
%%%%%%%%%%%%%


% tipoDeBeneficioMasAprovechado(Beneficio):-
%     gozaBeneficio(_ , Beneficio),
%     forall((gozaBeneficio(_, OtroBeneficio), Beneficio \= OtroBeneficio) , loUsanMas(Beneficio, OtroBeneficio)).

% cuantosLoUsan(Beneficio, Cantidad):-
%     gozaBeneficio(_, Beneficio),
%     findall(Persona, gozaBeneficio(Persona, Beneficio) , ListaDePersonas),
%     length(ListaDePersonas, Cantidad).



% loUsanMas(UnBeneficio, OtroBeneficio):-
%     cuantosLoUsan(UnBeneficio, Cuantos),
%     cuantosLoUsan(OtroBeneficio, OtrosCuantos),
%     Cuantos >= OtrosCuantos.


tipoDeBeneficioMasAprovechado(Tipo) :-
    tipoDeBeneficio(_, Tipo),
    forall(tipoDeBeneficio(_, OtroTipo) , supera(Tipo, OtroTipo)).



supera(Tipo, OtroTipo) :-
    tipoDeBeneficio(_, Tipo),
    tipoDeBeneficio(_, OtroTipo),
    cuantosLoUsan(Tipo, Cuantos),
    cuantosLoUsan(OtroTipo, OtrosCuantos),
    Cuantos >= OtrosCuantos.


cuantosLoUsan(Tipo, Cuantos) :-
    gozaBeneficio(_, Beneficio),
    tipoDeBeneficio(Beneficio, Tipo),
    findall(Magio, gozaBeneficioPorTipo(Magio, Tipo) , Magios),
    length(Magios, Cuantos).



tipoDeBeneficio(confort(_), confort).
tipoDeBeneficio(confort(_, _), confort).
tipoDeBeneficio(dispersion(_), dispersion).
tipoDeBeneficio(economico(_,_), economico).


gozaBeneficioPorTipo(Magio, Tipo) :-
    gozaBeneficio(Magio, Beneficio),
    tipoDeBeneficio(Beneficio, Tipo).