import Text.Show.Functions
import Data.List


data Jugador = Jugador {
    nombreJugador :: String,
    edad          :: Int,
    promedioGol   :: Float,
    habilidad     :: Int,
    cansancio     :: Float
}deriving (Show)

mapCansancio :: (Float -> Float) -> Jugador -> Jugador
mapCansancio funcion unJugador = unJugador {cansancio = funcion . cansancio $ unJugador}

type Equipo = (String , Char , [Jugador])

nombreEquipo :: Equipo -> String
nombreEquipo (unNombre , _ , _)      = unNombre

grupo :: Equipo -> Char
grupo        (_ , unGrupo , _)       = unGrupo

jugadores :: Equipo -> [Jugador]
jugadores    (_ , _ , unosJugadores) = unosJugadores

mapJugadores :: ([Jugador] -> [Jugador]) -> Equipo -> Equipo
mapJugadores funcion (x,y,z) = (x , y , funcion z)

-- Objetos

martin = Jugador "Martin" 26 0.0 50 35.0

juan = Jugador "Juancho" 30 0.2 50 40.0

maxi = Jugador "Maxi Lopez" 27 0.4 68 30.0

jonathan = Jugador "Chueco" 20 1.5 80 99.0

lean = Jugador "Hacha" 23 0.01 50 35.0

brian = Jugador "Panadero" 21 5 80 15.0

garcia = Jugador "Sargento" 30 1 80 13.0

messi = Jugador "Pulga" 26 10 99 43.0

aguero = Jugador "Aguero" 24 5 90 5.0


equipo1 = ("Lo Que Vale Es El Intento", 'F', [martin, juan, maxi])

losDeSiempre = ( "Los De Siempre", 'F', [jonathan, lean, brian])

restoDelMundo = ("Resto del Mundo", 'A', [garcia, messi, aguero])

altoEquipo = ("" , 'a' , [garcia, messi, aguero , jonathan, lean, brian , martin, juan, maxi , martin, juan, maxi])

-- funcion que puede ayudar

quickSort _ [] = []
quickSort criterio (x:xs) = (quickSort criterio . filter (not . criterio x)) xs ++ [x] ++ (quickSort criterio . filter (criterio x)) xs


-------------
-- Punto 1 --
-------------

figurasDelEquipo :: Equipo -> [Jugador]
figurasDelEquipo unEquipo = filter (esFigura) . jugadores $ unEquipo

esFigura :: Jugador -> Bool
esFigura unJugador = ((>75) . habilidad $ unJugador) && ((>0) . promedioGol $ unJugador)


-------------
-- Punto 2 --
-------------

jugadoresFaranduleros = ["Maxi Lopez", "Icardi", "Aguero", "Caniggia", "Demichelis"]

tieneFarandulero :: Equipo -> Bool
tieneFarandulero unEquipo = any (esFarandulero) . jugadores $ unEquipo

esFarandulero :: Jugador -> Bool
esFarandulero unJugador = elem (nombreJugador unJugador) jugadoresFaranduleros


-------------
-- Punto 3 --
-------------

serFiguritasDificiles :: [Equipo] -> Char -> [String]
serFiguritasDificiles unosEquipos unGrupo = map (nombreJugador) . filter (esJugadorDificil) . concatMap (jugadores) . filter(esDelGrupo unGrupo) $ unosEquipos
 
esDelGrupo :: Char -> Equipo -> Bool
esDelGrupo unGrupo unEquipo = (== unGrupo) . grupo $ unEquipo

esJugadorDificil :: Jugador -> Bool
esJugadorDificil unJugador = (esFigura unJugador) && (esJoven unJugador) && (not . esFarandulero $ unJugador)

esJoven :: Jugador -> Bool
esJoven jugador = (<27) . edad $ jugador



-------------
-- Punto 4 --
-------------



jugarPartido :: Equipo -> Equipo
jugarPartido unEquipo = mapJugadores (cansarJugadores) unEquipo

cansarJugadores :: [Jugador] -> [Jugador]
cansarJugadores unosJugadores = map (cansar) unosJugadores

cansar :: Jugador -> Jugador
cansar unJugador 
 | esJugadorDificil unJugador = mapCansancio (const 50) unJugador
 | esFiguraVieja              = mapCansancio (+ 20) unJugador
 | restoJoven                 = aumentarEnPorcentaje 10 unJugador
 | otherwise                  = mapCansancio (*2) unJugador
 where esFiguraVieja = (not.esJoven $ unJugador) && (esFigura unJugador)
       restoJoven    = (not . esFigura $ unJugador) && (esJoven unJugador) && (esFarandulero $ unJugador)


aumentarEnPorcentaje :: Float -> Jugador ->  Jugador
aumentarEnPorcentaje n unJugador = mapCansancio ((+) (porcentaje n (cansancio unJugador))) unJugador

porcentaje :: Float -> Float -> Float
porcentaje x y = (x * y) / 100


-------------
-- Punto 5 --
-------------



quienGanaEntre :: Equipo -> Equipo -> Equipo
quienGanaEntre unEquipo otroEquipo = jugarPartido $ ganador (mapJugadores (menosCansados) unEquipo) (mapJugadores (menosCansados) otroEquipo)

ganador :: Equipo -> Equipo -> Equipo
ganador unEquipo otroEquipo 
 |sumaDePromedio unEquipo > sumaDePromedio otroEquipo = unEquipo
 | otherwise                                          = otroEquipo

sumaDePromedio :: Equipo -> Float
sumaDePromedio unEquipo = sum . map (promedioGol) . jugadores $ unEquipo

menosCansados :: [Jugador] -> [Jugador]
menosCansados jugadores = take 11 . quickSort (tieneMasPilas) $ jugadores 

tieneMasPilas :: Jugador -> Jugador -> Bool
tieneMasPilas unJugador otroJugador = (cansancio unJugador) > (cansancio otroJugador)



-------------
-- Punto 6 --
-------------

ganadorDelGrupo1 :: [Equipo] -> Equipo
ganadorDelGrupo1 [equipo] = jugarPartido equipo
ganadorDelGrupo1 (primerEquipo : equipo2 : equipos) = ganadorDelGrupo1 ((ganador primerEquipo equipo2) : equipos) 

ganadorDelGrupo2 :: [Equipo] -> Equipo
ganadorDelGrupo2 unosEquipos = jugarPartido $ foldl1 (ganador) unosEquipos



-------------
-- Punto 7 --
-------------

elGroso :: [Equipo] -> Maybe Jugador
elGroso unosEquipos = find (esFigura) . jugadores . ganadorDelGrupo1 $ unosEquipos

elGroso2 :: [Equipo] ->  Jugador
elGroso2 unosEquipos = head . filter(esFigura) . jugadores . ganadorDelGrupo1 $ unosEquipos


-------------
-- Teorico --
-------------

{-
1) en todos lados xd

2) Si tuviese una lista de infinitos jugadores, habria problemas en las partes del codigo que requieren ese campo,
como por ejemplo, no se puede saber el ganador entre ese equipo y otro, ya que al sumar el promedio de cada jugador
estaria sumando infinitamente los numeros de cada jugador.

-}
