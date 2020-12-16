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
    persona(alMando(Persona,_)).

esNovato(UnMagio):-
    persona(novato(Persona)).

esElegido(UnMagio):-
    persona(elElegido(Persona)).
    


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


    
    
    
    