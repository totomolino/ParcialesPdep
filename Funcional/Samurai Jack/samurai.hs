import Text.Show.Functions


data Elemento = Elemento { 
    tipo :: String,
    ataque :: (Personaje-> Personaje),
    defensa :: (Personaje-> Personaje) 
}deriving (Show)

data Personaje = Personaje { 
 nombre :: String,
 vida :: Float,
 elementos :: [Elemento],
 anioPresente :: Int 
}deriving (Show)

mapAnio :: (Int -> Int) -> Personaje -> Personaje
mapAnio funcion personaje = personaje {anioPresente = funcion . anioPresente $ personaje}

mapVida :: (Float -> Float) -> Personaje -> Personaje
mapVida funcion personaje = personaje {vida = funcion . vida $ personaje}

sumarVida :: Float -> Personaje -> Personaje
sumarVida cuanto unPersonaje = mapVida (+ cuanto) unPersonaje

restarVida :: Float -> Personaje -> Personaje
restarVida cuanto unPersonaje = mapVida (subtract cuanto) unPersonaje


atacarA :: Personaje -> Elemento -> Personaje
atacarA unRival unElemento = ($ unRival) . ataque $ unElemento 

defenderse :: Personaje -> Elemento -> Personaje
defenderse unPersonaje unElemento = ($ unPersonaje) . defensa $ unElemento 


-- objetos



thanos :: Personaje
thanos = Personaje {nombre = "Thanos" , vida = 5000 , elementos = [matador] , anioPresente = 2020}

maquinaMala :: Elemento
maquinaMala = Elemento {tipo = "Maldad" , ataque = causarDanio 10 , defensa = meditar }

matador :: Elemento 
matador = Elemento {tipo = "Maldad" , ataque = causarDanio 1000000 , defensa = meditar}

-------------
-- Punto 1 --
-------------

mandarAlAnio :: Int -> Personaje ->  Personaje
mandarAlAnio unAnio unPersonaje  = mapAnio (const unAnio) unPersonaje


meditar :: Personaje -> Personaje
meditar unPersonaje = sumarVida ((*2) . vida $ unPersonaje) unPersonaje

causarDanio ::  Float -> Personaje -> Personaje
causarDanio danio unPersonaje = mapVida ((max 0) . subtract danio) unPersonaje


-------------
-- Punto 2 --
-------------

esMalvado :: Personaje -> Bool
esMalvado unPersonaje = elem "Maldad" . map tipo . elementos $ unPersonaje

danioQueProduce :: Personaje -> Elemento -> Float 
danioQueProduce unPersonaje unElemento = (vida unPersonaje) - (vida $ atacarA unPersonaje unElemento)

enemigosMortales :: Personaje -> [Personaje] -> [Personaje]
enemigosMortales unPersonaje unosEnemigos = filter (puedeMatar unPersonaje) unosEnemigos

puedeMatar :: Personaje -> Personaje -> Bool
puedeMatar unPersonaje unEnemigo = loMatanConUno unPersonaje (elementos unEnemigo)


loMatanConUno :: Personaje -> [Elemento] -> Bool
loMatanConUno      _       []                     = False
loMatanConUno unPersonaje (elemento1 : elementos) = (danioQueProduce unPersonaje elemento1 >= (vida unPersonaje)) ||loMatanConUno unPersonaje elementos


-------------
-- Punto 3 --
-------------


aplicarNVeces :: Int -> (a -> a) -> a -> a

aplicarNVeces number funcion valor = foldr ($) valor (replicate number funcion)

concentracion :: Int -> Elemento
concentracion n = Elemento {tipo = "Magia" , defensa = aplicarNVeces n meditar , ataque = id}


esbirrosMalvados :: Int -> [Elemento]
esbirrosMalvados cantidad = (replicate cantidad esbirro)

esbirro :: Elemento
esbirro = Elemento {tipo = "Maldad" , ataque = causarDanio 1 , defensa = id}


jack :: Personaje 
jack = Personaje {nombre = "Jack" , vida = 300 , elementos = [concentracion 3 , katanaMagica] , anioPresente = 200}

katanaMagica ::Elemento
katanaMagica = Elemento {tipo = "Magia" , ataque = causarDanio 1000 , defensa = id }


aku :: Int -> Float -> Personaje
aku anio salud = Personaje {nombre = "Aku" , vida = salud , elementos = [concentracion 4 , portalAlFuturo anio ] ++ esbirrosMalvados (100 * anio) , anioPresente = anio }

portalAlFuturo :: Int  -> Elemento
portalAlFuturo anio = Elemento {tipo = "Magia" , ataque = mandarAlAnio (anio + 2800) , defensa = generarAku (anio + 2800) }

generarAku :: Int  -> Personaje -> Personaje
generarAku anio unPersonaje = mandarAlAnio (anio) unPersonaje


-------------
-- Punto 4 --
-------------


luchar :: Personaje -> Personaje -> (Personaje , Personaje)
luchar unAtacante unDefensor 
  | estaMuerto unAtacante  = (unDefensor , unAtacante)
  | otherwise  = luchar proximoAtacante proximoDefensor
 where proximoAtacante = usarElementos ataque unDefensor (elementos unAtacante)
       proximoDefensor = usarElementos defensa unAtacante (elementos unAtacante)




usarElementos :: (Elemento -> Personaje -> Personaje) -> Personaje -> [Elemento] -> Personaje
usarElementos funcion personaje elementos = foldl afectar personaje (map funcion elementos)


estaMuerto :: Personaje -> Bool
estaMuerto unPersonaje = (== 0) . vida $ unPersonaje

afectar = flip ($)






-------------
-- Punto 5 --
-------------

{-

inferir tipo de  : f x y z
                         | y 0 == z = map (fst.x z)
                         | otherwise = map (snd.x (y 0))

f :: (Eq a , Num d)  => ( a ->  b ->  (c , c)) -> (d -> a)   -> a  -> [b]  -> [c] 

f :: (Eq t1, Num t2) => (t1 -> a1 -> (a2, a2)) -> (t2 -> t1) -> t1 -> [a1] -> [a2]

-}

f x y z
                         | y 0 == z = map (fst.x z)
                         | otherwise = map (snd.x (y 0))