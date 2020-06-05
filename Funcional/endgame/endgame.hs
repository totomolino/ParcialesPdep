import Text.Show.Functions

type Nombre = String
type Planeta = String


data Artefacto = Artefacto {
    nombreArtefacto :: Nombre,
    daño   :: Int
}deriving (Show,Eq)

mapNombreArtefacto :: (Nombre -> Nombre) -> Artefacto -> Artefacto
mapNombreArtefacto funcion artefacto = artefacto {nombreArtefacto = funcion (nombreArtefacto artefacto)}

mapDaño :: (Int -> Int) -> Artefacto -> Artefacto
mapDaño funcion artefacto = artefacto {daño = funcion (daño artefacto)}

data SuperHeroe = SuperHeroe {
    nombreSuper :: Nombre,
    vida   :: Float,
    planeta :: Planeta,
    artefacto :: Artefacto,
    enemigo   :: Villano
}deriving (Show)

mapVida :: (Float -> Float) -> SuperHeroe -> SuperHeroe
mapVida funcion superHeroe = superHeroe {vida = funcion (vida superHeroe)}

mapArtefacto :: (Artefacto -> Artefacto) -> SuperHeroe -> SuperHeroe
mapArtefacto funcion superHeroe = superHeroe {artefacto = funcion (artefacto superHeroe)}

mapNombreSuper :: (Nombre -> Nombre) -> SuperHeroe -> SuperHeroe
mapNombreSuper funcion superHeroe = superHeroe {nombreSuper = funcion (nombreSuper superHeroe)}


data Villano = Villano {
    nombreVillano :: Nombre,
    planetaVillano :: Planeta,
    arma    :: Arma
}deriving (Show)

type Arma = SuperHeroe -> SuperHeroe

-- Artefactos

traje :: Artefacto
traje = Artefacto "Traje" 12

stormbreaker :: Artefacto
stormbreaker = Artefacto "StormBreaker" 0

-- Superheroes

ironMan :: SuperHeroe
ironMan = SuperHeroe "Tony Stark" 100 "Tierra" traje thanos

thor    :: SuperHeroe
thor    = SuperHeroe "Thor Odinson" 300 "Asgard" stormbreaker loki

ironManPt :: SuperHeroe
ironManPt = SuperHeroe "Tony" 20 "Tierra" traje loki


-- Villanos

thanos :: Villano
thanos = Villano "Thanos" "Titan" guanteleteDelInfinito

loki :: Villano
loki = Villano "Loki Laufeyson" "Jotunheim" (cetro 20)


-- Armas

guanteleteDelInfinito :: Arma
guanteleteDelInfinito superHeroe = sacarVida 80 superHeroe

sacarVida :: Float -> SuperHeroe -> SuperHeroe
sacarVida porcentaje superHeroe =  mapVida (calculoPorcentaje porcentaje ) superHeroe  
  
calculoPorcentaje :: Float -> Float -> Float
calculoPorcentaje porcentaje vida = vida - (( porcentaje * vida) / 100)


cetro :: Float -> Arma
cetro porcentaje unSuperHeroe | viveEn "Tierra" unSuperHeroe = (sacarVida  porcentaje) $ (romperArtefacto  unSuperHeroe)
                              | otherwise = (sacarVida porcentaje) unSuperHeroe 

romperArtefacto :: SuperHeroe -> SuperHeroe
romperArtefacto unSuperHeroe = mapArtefacto  (mapDaño (+30) . mapNombreArtefacto (++ " Machacado")) unSuperHeroe

viveEn :: Planeta -> SuperHeroe -> Bool
viveEn lugar superHeroe = (== lugar) . planeta  $ superHeroe




-- punto 3 

sonAntagonistas :: Villano -> SuperHeroe -> Bool
sonAntagonistas unVillano unSuperHeroe =    mismoPlaneta unVillano unSuperHeroe   || esVillanoDe unVillano unSuperHeroe


mismoPlaneta :: Villano -> SuperHeroe -> Bool
mismoPlaneta malo bueno = (== planeta bueno) . planetaVillano $ malo

esVillanoDe :: Villano -> SuperHeroe -> Bool
esVillanoDe unVillano unSuperHeroe = ((== (nombreVillano unVillano)) $ (nombreVillano . enemigo $ unSuperHeroe))



-- punto 4

ataqueEnGrupo :: [Villano] -> SuperHeroe -> SuperHeroe
ataqueEnGrupo [villano]  unSuperHeroe            = atacarSi villano unSuperHeroe
ataqueEnGrupo (villano1 : villanos) unSuperHeroe =  ataqueEnGrupo villanos (atacarSi villano1 unSuperHeroe)

atacarSi ::  Villano -> SuperHeroe ->SuperHeroe
atacarSi unVillano  unSuperHeroe| sonAntagonistas unVillano unSuperHeroe = unSuperHeroe
                                | otherwise  = (arma unVillano) $ unSuperHeroe


-- punto 5

quienesSobreviven :: [SuperHeroe] -> Villano -> [SuperHeroe]
quienesSobreviven unosSuperHeroes unVillano = map siSobrevivio . filter (sobreviveA unVillano) $ unosSuperHeroes

sobreviveA :: Villano -> SuperHeroe -> Bool
sobreviveA unVillano unSuperHeroe = (>= 50) . vida . atacarSi unVillano $ unSuperHeroe

siSobrevivio :: SuperHeroe -> SuperHeroe
siSobrevivio superHeroe = mapNombreSuper ("Super " ++) superHeroe




-- punto 6


hogarDulceHogar :: [SuperHeroe] -> [SuperHeroe]
hogarDulceHogar unosSuperHeroes = map aDescansar (quienesSobreviven unosSuperHeroes thanos)

aDescansar :: SuperHeroe -> SuperHeroe
aDescansar unSuperHeroe =  arreglarArtefacto . (curar 30) $ unSuperHeroe

curar :: Float -> SuperHeroe -> SuperHeroe
curar cuanto unSuperHeroe = mapVida (+ cuanto) unSuperHeroe

arreglarArtefacto :: SuperHeroe -> SuperHeroe
arreglarArtefacto unSuperHeroe = mapArtefacto (mapDaño (const 0) . mapNombreArtefacto (noMachacado)) unSuperHeroe

noMachacado :: Nombre -> Nombre
noMachacado nombreRoto = unwords . filter (/= "Machacado") . words $ nombreRoto


-- punto 7

esDebil :: Villano -> [SuperHeroe] -> Bool
esDebil unVillano unosSuperHeroes = esAntagonista unVillano unosSuperHeroes && ningunoEstaMachacado unosSuperHeroes

esAntagonista :: Villano -> [SuperHeroe] -> Bool
esAntagonista unVillano unosSuperHeroes = all (sonAntagonistas unVillano) unosSuperHeroes

ningunoEstaMachacado :: [SuperHeroe] -> Bool
ningunoEstaMachacado unosSuperHeroes = all (not . estaMachacado . nombreArtefacto . artefacto) $ unosSuperHeroes

estaMachacado :: Nombre -> Bool
estaMachacado nombre = any (== "Machacado") [nombre]


-- Punto 8

drStrange :: SuperHeroe
drStrange = SuperHeroe {nombreSuper = "Stephen Strange" , planeta = "Tierra", vida = 60, artefacto = capa, enemigo = thanos }

capa :: Artefacto
capa = Artefacto "Capa de levitacion" 0


--infinitosDoctores  = [nombreSuper drStrange] ++ (map ( (nombreSuper drStrange ++) . (" " ++) . show) (iterate (+1) 1))

--infinitosDoctores  =  [drStrange] ++ mapNombreSuper (map ((" " ++) . show) (iterate (+1) 1)) superHeroe 

infinitosDoctores :: [SuperHeroe]
infinitosDoctores = map (funcion . show) listaDeNumeros 

funcion :: String -> SuperHeroe
funcion numero = mapNombreSuper (++ " " ++ numero) drStrange

listaDeNumeros :: [Int]
listaDeNumeros = iterate (+1) 1

{- punto 9


a) No, porque va a ser una lista de doctores infinita que sobrevivieron, todos sobreviven a thanos, por lo tanto devuelve la lista infinita.


b)




-}


